#!/usr/bin/env bash
hook_dir="${BASH_SOURCE[0]%/*}"
bash "$hook_dir/notify-common.sh" "Codexの応答が完了しました"
# Stop hook の標準出力には JSON を返す。
printf '{}\n'
exit 0
