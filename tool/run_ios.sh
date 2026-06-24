#!/bin/zsh

set -eu

script_dir="${0:A:h}"
export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"

device_id="$("$script_dir/boot_ios_simulator.sh")"

print "Flutterをdebugモードで起動します。"
print "実行中は r でHot Reload、R でHot Restart、q で終了できます。"

exec flutter run -d "$device_id" "$@"
