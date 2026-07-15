#!/usr/bin/env bash
# Stop hook: 応答完了のたびに、会話内容からセッション名を自動生成して rename する。
# 時間のかかる処理（モデル呼び出し）は auto-rename-worker.sh に切り離して
# バックグラウンドで実行し、hook 自体は即座に終了して応答をブロックしない。
set -euo pipefail

INPUT="$(cat)"

# worker 内の claude -p は --setting-sources "" で user settings（この hook 含む）を
# 読まない設定にしているが、万一読まれた場合に再帰起動しないための保険
if [[ -n "${AUTO_RENAME_INNER:-}" ]]; then
    exit 0
fi

SID="$(printf '%s' "$INPUT" | jq -r '.session_id // empty')"
TRANSCRIPT="$(printf '%s' "$INPUT" | jq -r '.transcript_path // empty')"
if [[ -z "$SID" || -z "$TRANSCRIPT" ]]; then
    exit 0
fi

WORKER="$(cd "$(dirname "$0")" && pwd)/auto-rename-worker.sh"
if [[ ! -x "$WORKER" ]]; then
    exit 0
fi

nohup "$WORKER" "$SID" "$TRANSCRIPT" >/dev/null 2>&1 &
disown 2>/dev/null || true
exit 0
