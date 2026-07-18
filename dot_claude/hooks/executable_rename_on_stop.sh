#!/usr/bin/env bash
# Stop hook: このイベントを発火させたセッション自身を自動リネームする薄いディスパッチャ。
# ガード判定だけ行い、本体 (claude-rename-auto) は setsid で切り離して即 exit 0 する
# （Stop hook で非ゼロ終了や exit 2 を返すと停止ブロック等の別機能が発動するため）。
#
# ガード:
# - stop_hook_active=true のイベントは無視
# - last_assistant_message のハッシュが前回と同じならスキップ（内容が変わったターンだけ命名）
# - セッション単位の flock で多重実行を防止
# 状態ファイル（ハッシュ・ロック）と実行ログは /tmp/claude-rename-auto/ に置く。
# 再起動で消えても余分な命名が1回走るだけで実害はない
set -uo pipefail

INPUT=$(cat)
STATE_DIR=/tmp/claude-rename-auto
LOG="$STATE_DIR/rename.log"
RENAMER="${CLAUDE_RENAME_AUTO:-$HOME/.local/bin/claude-rename-auto}"

command -v jq >/dev/null || exit 0
command -v flock >/dev/null || exit 0

sid="$(jq -r '.session_id // empty' <<<"$INPUT")"
active="$(jq -r '.stop_hook_active // false' <<<"$INPUT")"
last="$(jq -r '.last_assistant_message // ""' <<<"$INPUT")"
cwd="$(jq -r '.cwd // empty' <<<"$INPUT")"

[[ -n "$sid" ]] || exit 0
[[ "$active" == "true" ]] && exit 0

mkdir -p "$STATE_DIR"
hash="$(printf '%s' "$last" | sha256sum | cut -d' ' -f1)"
hash_file="$STATE_DIR/$sid.hash"
[[ -f "$hash_file" && "$(cat "$hash_file")" == "$hash" ]] && exit 0

export RENAMER sid cwd hash hash_file LOG
setsid bash -c '
    exec </dev/null >>"$LOG" 2>&1
    exec 9>>"'"$STATE_DIR"'/$sid.lock"
    flock -n 9 || exit 0
    if "$RENAMER" "$sid" "$cwd"; then
        printf "%s" "$hash" > "$hash_file"
        echo "$(date "+%F %T") renamed sid=$sid"
    else
        echo "$(date "+%F %T") failed sid=$sid"
    fi
' &

exit 0
