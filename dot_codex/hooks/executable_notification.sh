#!/usr/bin/env bash
hook_dir="${BASH_SOURCE[0]%/*}"
bash "$hook_dir/notify-common.sh" "Codexが操作の承認を待っています"
exit 0
