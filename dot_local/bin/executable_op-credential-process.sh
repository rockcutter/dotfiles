#!/bin/bash
ITEM_NAME="$1"
[ -z "$ITEM_NAME" ] && echo "Error: Item name required" >&2 && exit 1

ACCESS_KEY=$(op item get "$ITEM_NAME" --fields label="access key id")
SECRET_KEY=$(op item get "$ITEM_NAME" --fields label="secret access key" --reveal)
MFA_SERIAL=$(op item get "$ITEM_NAME" --fields label="mfa serial")
OTP_CODE=$(op item get "$ITEM_NAME" --otp)

# 元の認証情報を環境変数でaws cliに渡す
SESSION=$(AWS_ACCESS_KEY_ID="$ACCESS_KEY" \
  AWS_SECRET_ACCESS_KEY="$SECRET_KEY" \
  aws sts get-session-token \
  --serial-number "$MFA_SERIAL" \
  --token-code "$OTP_CODE" \
  --output json \
  --no-cli-pager \
  2>/dev/null)

SESSION_ACCESS_KEY=$(echo "$SESSION" | jq -r '.Credentials.AccessKeyId')
SESSION_SECRET_KEY=$(echo "$SESSION" | jq -r '.Credentials.SecretAccessKey')
SESSION_TOKEN=$(echo "$SESSION" | jq -r '.Credentials.SessionToken')

cat <<EOF
{
  "Version": 1,
  "AccessKeyId": "$SESSION_ACCESS_KEY",
  "SecretAccessKey": "$SESSION_SECRET_KEY",
  "SessionToken": "$SESSION_TOKEN"
}
EOF
