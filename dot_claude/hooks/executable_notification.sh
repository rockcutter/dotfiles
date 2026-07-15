#!/bin/bash
LOG=~/.claude/hooks/notification.log
INPUT=$(cat)
{
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') PID=$$ PPID=$PPID TMUX_PANE=$TMUX_PANE ==="
  echo "$INPUT"
  echo ""
} >> "$LOG"

# idle_prompt は Stop hook と重複するためスキップ
NOTIFICATION_TYPE=$(echo "$INPUT" | jq -r '.notification_type // ""')
if [[ "$NOTIFICATION_TYPE" == "idle_prompt" ]]; then
  exit 0
fi

if [[ "$(uname)" == "Darwin" ]]; then
  osascript -e 'display notification "Claude Codeが入力を待っています" with title "Claude Code" sound name "Glass"'
else
  notify-send "Claude Code" "Claude Codeが入力を待っています"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
fi
tmux display-popup -w 60% -h 20% -E "figlet -c 'claude is calling'; sleep 0.5"
# tmux display-popup -w 60% -h 20% -E "figlet -c 'claude is calling'; sleep 30"
