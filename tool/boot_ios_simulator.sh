#!/bin/zsh

set -e

export DEVELOPER_DIR="/Applications/Xcode.app/Contents/Developer"

device_id="1408BF6F-BC9F-4CB1-8B07-78FC62703B8D"

if ! /usr/bin/xcrun simctl list devices booted | /usr/bin/grep -q "$device_id"; then
  /usr/bin/xcrun simctl boot "$device_id"
fi

/usr/bin/xcrun simctl bootstatus "$device_id" -b
/usr/bin/open -a Simulator
