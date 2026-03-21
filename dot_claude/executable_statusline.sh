#!/bin/bash
input=$(cat)

MODEL=$(echo "$input" | jq -r '.model.display_name')
PCT=$(echo "$input" | jq -r '.context_window.used_percentage // 0' | cut -d. -f1)
INPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_input_tokens // 0')
OUTPUT_TOKENS=$(echo "$input" | jq -r '.context_window.total_output_tokens // 0')
COST=$(echo "$input" | jq -r '.cost.total_cost_usd // 0')
DURATION_MS=$(echo "$input" | jq -r '.cost.total_duration_ms // 0')
API_DURATION_MS=$(echo "$input" | jq -r '.cost.total_api_duration_ms // 0')
FIVE_H=$(echo "$input" | jq -r '.rate_limits.five_hour.used_percentage // empty')
FIVE_H_RESET=$(echo "$input" | jq -r '.rate_limits.five_hour.resets_at // empty')
SEVEN_D=$(echo "$input" | jq -r '.rate_limits.seven_day.used_percentage // empty')
TOTAL=$((INPUT_TOKENS + OUTPUT_TOKENS))

DURATION_S=$((DURATION_MS / 1000))
DURATION_M=$((DURATION_S / 60))
DURATION_S=$((DURATION_S % 60))
if [ "$DURATION_M" -gt 0 ]; then
  DURATION="${DURATION_M}m${DURATION_S}s"
else
  DURATION="${DURATION_S}s"
fi

API_S=$((API_DURATION_MS / 1000))
API_M=$((API_S / 60))
API_S=$((API_S % 60))
if [ "$API_M" -gt 0 ]; then
  API_DURATION="${API_M}m${API_S}s"
else
  API_DURATION="${API_S}s"
fi

LIMITS=""
if [ -n "$FIVE_H" ]; then
  FIVE_H_INT=$(printf '%.0f' "$FIVE_H")
  LIMITS="5h:${FIVE_H_INT}%"
  if [ -n "$FIVE_H_RESET" ]; then
    RESET_TIME=$(date -d "@${FIVE_H_RESET}" '+%H:%M' 2>/dev/null || date -r "${FIVE_H_RESET}" '+%H:%M' 2>/dev/null)
    [ -n "$RESET_TIME" ] && LIMITS="${LIMITS}(~${RESET_TIME})"
  fi
fi
[ -n "$SEVEN_D" ] && LIMITS="${LIMITS:+$LIMITS }7d:$(printf '%.0f' "$SEVEN_D")%"

[ -n "$LIMITS" ] && echo "$LIMITS"
echo "[$MODEL] Context: ${PCT}% | \$${COST}"
echo "${TOTAL} tokens (in:${INPUT_TOKENS} out:${OUTPUT_TOKENS})"
echo "${DURATION} (API:${API_DURATION})"
