#!/usr/bin/env bash
# セッションの表示名を書き換える。対象セッションは第2引数の session-id、
# 省略時は環境変数 CLAUDE_CODE_SESSION_ID（= カレントセッション）で特定する。
# 書き換え対象:
#   ~/.claude/jobs/<jobId>/state.json  bgジョブの永続ストア。agent view のbgジョブ行の表示元
#   ~/.claude/sessions/<pid>.json      実行中セッションのレジストリ。claude agents --json の表示元
# どちらも Claude Code の非公開の内部ファイルのため、構造変更で動かなくなったら要追従。
set -euo pipefail

NEW_NAME="${1:?usage: rename_session.sh <new-name> [session-id]}"
SID="${2:-${CLAUDE_CODE_SESSION_ID:-}}"
SESSIONS_DIR="${HOME}/.claude/sessions"
JOBS_DIR="${HOME}/.claude/jobs"

if ! command -v jq >/dev/null 2>&1; then
    echo "error: jq is required" >&2
    exit 1
fi

if [[ -z "$SID" ]]; then
    echo "error: session id is unknown (pass it as the 2nd arg, or run inside a Claude Code session)" >&2
    exit 1
fi

# cp -p で元ファイルのパーミッションを引き継ぎ、同一ディレクトリ内の mv で置き換える
rewrite_name() {
    local file="$1"
    local tmp="${file}.tmp.$$"
    cp -p "$file" "$tmp"
    jq --arg name "$NEW_NAME" '.name = $name | .nameSource = "user"' "$file" > "$tmp"
    mv "$tmp" "$file"
    echo "updated: $file"
}

updated=0

# bgジョブの永続ストア: sessionId が一致する state.json を探す
for f in "$JOBS_DIR"/*/state.json; do
    [[ -e "$f" ]] || continue
    if [[ "$(jq -r '.sessionId // empty' "$f")" == "$SID" ]]; then
        rewrite_name "$f"
        updated=1
    fi
done

# 実行中セッションのレジストリ: sessionId が一致するファイルを探す
for f in "$SESSIONS_DIR"/*.json; do
    [[ -e "$f" ]] || continue
    if [[ "$(jq -r '.sessionId // empty' "$f")" == "$SID" ]]; then
        rewrite_name "$f"
        updated=1
    fi
done

if [[ "$updated" -eq 0 ]]; then
    echo "error: no session file found for sessionId=$SID" >&2
    exit 1
fi

echo "renamed session to: $NEW_NAME"
