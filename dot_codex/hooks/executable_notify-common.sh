#!/usr/bin/env bash
# 通知機能が使えない環境でも、Codex の処理を妨げずに終了する。
message="${1:-Codexが入力を待っています}"

if [[ "$(uname)" == "Darwin" ]]; then
  if command -v osascript >/dev/null 2>&1; then
    osascript - "$message" >/dev/null 2>&1 <<'APPLESCRIPT' || true
on run argv
  display notification (item 1 of argv) with title "Codex" sound name "Glass"
end run
APPLESCRIPT
  fi
else
  if command -v notify-send >/dev/null 2>&1; then
    notify-send "Codex" "$message" >/dev/null 2>&1 || true
  fi
  if command -v paplay >/dev/null 2>&1 && [[ -r /usr/share/sounds/freedesktop/stereo/complete.oga ]]; then
    paplay /usr/share/sounds/freedesktop/stereo/complete.oga >/dev/null 2>&1 || true
  fi
fi

if [[ -n "${TMUX:-}" && -n "${TMUX_PANE:-}" ]] && command -v tmux >/dev/null 2>&1; then
  tmux select-window -t "$TMUX_PANE" >/dev/null 2>&1 || true
  if command -v figlet >/dev/null 2>&1; then
    tmux display-popup -t "$TMUX_PANE" -w 60% -h 20% -E "figlet -c 'codex is calling'; sleep 0.5" >/dev/null 2>&1 || true
  fi
fi
exit 0
