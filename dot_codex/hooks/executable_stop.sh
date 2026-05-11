#!/bin/bash
tmux select-window -t "$TMUX_PANE"
if [[ "$(uname)" == "Darwin" ]]; then
  osascript -e 'display notification "Codexが入力を待っています" with title "Codex" sound name "Glass"'
else
  notify-send "Codex" "Codexが入力を待っています"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
fi
tmux display-popup -w 60% -h 20% -E "figlet -c 'codex is calling'; sleep 0.5"
# tmux display-popup -w 60% -h 20% -E "figlet -c 'codex is calling'; sleep 30"
