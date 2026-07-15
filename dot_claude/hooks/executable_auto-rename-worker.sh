#!/usr/bin/env bash
# auto-rename-hook.sh から切り離されて起動される非同期 worker。
# セッションの transcript からテキストを抜粋して haiku に渡し、
# 「<タスク名>_<現在の状況>」形式の日本語セッション名を生成して反映する。
# 実行記録は ~/.claude/auto-rename/worker.log に残る。
#
# 環境変数による上書き（主にテスト用）:
#   AUTO_RENAME_SCRIPT: rename_session.sh のパス
#   AUTO_RENAME_MODEL:  名前生成に使うモデル
set -euo pipefail

SID="${1:?usage: auto-rename-worker.sh <session-id> <transcript-path>}"
TRANSCRIPT="${2:?usage: auto-rename-worker.sh <session-id> <transcript-path>}"

STATE_DIR="${HOME}/.claude/auto-rename"
LOG="${STATE_DIR}/worker.log"
RENAME_SCRIPT="${AUTO_RENAME_SCRIPT:-${HOME}/.claude/skills/rename-session/scripts/rename_session.sh}"
MODEL="${AUTO_RENAME_MODEL:-claude-haiku-4-5-20251001}"

mkdir -p "$STATE_DIR"

log() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') [${SID:0:8}] $*" >> "$LOG"
}

# ログの肥大化防止
if [[ -f "$LOG" && "$(wc -c < "$LOG")" -gt 200000 ]]; then
    tail -c 100000 "$LOG" > "${LOG}.tmp.$$" && mv "${LOG}.tmp.$$" "$LOG"
fi

if [[ ! -f "$TRANSCRIPT" ]]; then
    log "skip: transcript not found: $TRANSCRIPT"
    exit 0
fi

# 同一セッションの worker 多重起動を防ぐ。実行中なら今回は何もしない
# （次の Stop hook でまた起動される）。flock が無い環境でも動くよう mkdir ロックを使い、
# 異常終了で残った古いロックは回収する
LOCK="${STATE_DIR}/${SID}.lock"
if [[ -d "$LOCK" && -n "$(find "$LOCK" -maxdepth 0 -mmin +5 2>/dev/null)" ]]; then
    rmdir "$LOCK" 2>/dev/null || true
fi
if ! mkdir "$LOCK" 2>/dev/null; then
    log "skip: another worker is running"
    exit 0
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

# transcript(.jsonl) からユーザー/アシスタント発話のテキストだけを取り出す
# （ツール呼び出しやツール結果の JSON は名前決めのノイズになるため除外）
TEXT="$(jq -r '
    select(.type == "user" or .type == "assistant")
    | .message.content
    | if type == "string" then .
      elif type == "array" then ([.[] | select(.type? == "text") | .text] | join("\n"))
      else empty end
    | select(length > 0)
' "$TRANSCRIPT" 2>/dev/null || true)"

if [[ -z "$TEXT" ]]; then
    log "skip: no text content in transcript"
    exit 0
fi

# 長い会話は冒頭（依頼内容）と末尾（現在の状況）だけをモデルに渡す
if [[ "$(printf '%s' "$TEXT" | wc -c)" -le 10000 ]]; then
    EXCERPT="$TEXT"
else
    EXCERPT="$(printf '%s' "$TEXT" | head -c 2000)
（中略）
$(printf '%s' "$TEXT" | tail -c 8000)"
fi

PROMPT='以下はコーディングエージェントとのセッションの会話抜粋。このセッションに「<タスク名>_<現在の状況>」形式の日本語セッション名を付けること。
- タスク名: セッションの主タスクを表す短い名詞句（15文字以内が目安）
- 現在の状況: 会話の末尾から判断した現在のフェーズ（例: 調査中 / 実装中 / レビュー待ち / ブロック中 / 完了）
- 全体で30文字以内。出力は名前だけを1行で。引用符・説明・前置きを付けない'

# --setting-sources "" で user settings を読ませず、内側セッションでの Stop hook 再帰を防ぐ。
# AUTO_RENAME_INNER は設定が読まれてしまった場合の保険（auto-rename-hook.sh 側で見る）
NAME="$(printf '%s' "$EXCERPT" | AUTO_RENAME_INNER=1 claude -p \
    --model "$MODEL" \
    --setting-sources "" \
    --no-session-persistence \
    "$PROMPT" 2>>"$LOG" || true)"

# 1行目だけ採用し、セッション名に不向きな文字を除去して40文字に制限する
NAME="$(printf '%s' "$NAME" | head -n 1 | tr -d '`"/\\' | tr -d "'" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
NAME="${NAME:0:40}"

if [[ -z "$NAME" ]]; then
    log "skip: model returned empty name"
    exit 0
fi

if OUT="$("$RENAME_SCRIPT" "$NAME" "$SID" 2>&1)"; then
    log "renamed to: $NAME"
else
    log "rename failed: $OUT"
fi
