#!/usr/bin/env bash
hook_dir="${BASH_SOURCE[0]%/*}"
bash "$hook_dir/notify-common.sh" "Codexの子エージェントの応答が完了しました"
printf '{}\n'
exit 0
