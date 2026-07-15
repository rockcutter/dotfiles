#!/bin/bash
LOG=~/.claude/hooks/stop.log
INPUT=$(cat)
{
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') PID=$$ PPID=$PPID TMUX_PANE=$TMUX_PANE ==="
  echo "$INPUT"
  echo ""
} >> "$LOG"

# background agent のセッションでは通知しない
# (親セッション側の agent_completed / agent_needs_input 通知と二重になるため)
AGENT_TYPE=$(echo "$INPUT" | jq -r '.agent_type // ""')
if [[ -n "$AGENT_TYPE" ]]; then
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
