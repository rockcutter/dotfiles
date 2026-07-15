#!/bin/bash
LOG=~/.claude/hooks/stop.log
INPUT=$(cat)
{
  echo "=== $(date '+%Y-%m-%d %H:%M:%S') PID=$$ PPID=$PPID TMUX_PANE=$TMUX_PANE ==="
  echo "$INPUT"
  echo ""
} >> "$LOG"

# background agent のセッション (agent_type あり) でも通知する。
# 親セッション側の agent_completed 通知は agent view を表示するまで
# 発火が遅延することがあり、実完了時に鳴らせるのはこの Stop hook のみ。
# 二重通知は notification.sh 側で親の中継通知をスキップして防ぐ

if [[ "$(uname)" == "Darwin" ]]; then
  osascript -e 'display notification "Claude Codeが入力を待っています" with title "Claude Code" sound name "Glass"'
else
  notify-send "Claude Code" "Claude Codeが入力を待っています"
  paplay /usr/share/sounds/freedesktop/stereo/complete.oga
fi
tmux display-popup -w 60% -h 20% -E "figlet -c 'claude is calling'; sleep 0.5"
# tmux display-popup -w 60% -h 20% -E "figlet -c 'claude is calling'; sleep 30"
