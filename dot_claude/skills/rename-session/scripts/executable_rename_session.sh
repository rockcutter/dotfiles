#!/usr/bin/env bash
# カレントセッション（CLAUDE_CODE_SESSION_ID で特定）の表示名を書き換える。
# 対象: $CLAUDE_JOB_DIR/state.json（bgジョブのみ）と ~/.claude/sessions/<pid>.json。
# どちらも Claude Code の非公開内部ファイルのため、構造変更で動かなくなったら要追従。
set -euo pipefail

NEW_NAME="${1:?usage: rename_session.sh <new-name>}"
SESSIONS_DIR="${HOME}/.claude/sessions"
SID="${CLAUDE_CODE_SESSION_ID:-}"

if ! command -v jq >/dev/null 2>&1; then
    echo "error: jq is required" >&2
    exit 1
fi

if [[ -z "$SID" ]]; then
    echo "error: CLAUDE_CODE_SESSION_ID is not set (run from inside a Claude Code session)" >&2
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

if [[ -n "${CLAUDE_JOB_DIR:-}" && -f "${CLAUDE_JOB_DIR}/state.json" ]]; then
    rewrite_name "${CLAUDE_JOB_DIR}/state.json"
    updated=1
fi

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

echo "renamed current session to: $NEW_NAME"
