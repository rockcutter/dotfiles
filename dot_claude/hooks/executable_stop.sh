#!/bin/bash
tmux select-window -t "$TMUX_PANE"
osascript -e 'display notification "処理が完了しました" with title "Claude Code" sound name "Glass"'
tmux display-popup -w 60% -h 20% -E "figlet -c 'claude is calling'; sleep 0.5"