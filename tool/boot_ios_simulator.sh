#!/bin/zsh

set -eu

export DEVELOPER_DIR="${DEVELOPER_DIR:-/Applications/Xcode.app/Contents/Developer}"

device_id="${IOS_SIMULATOR_DEVICE_ID:-}"

if [[ -z "$device_id" ]]; then
  device_id="$(
    /usr/bin/xcrun simctl list devices booted |
      /usr/bin/sed -nE '/iPhone/ s/.*\(([0-9A-F-]{36})\) \(Booted\).*/\1/p' |
      /usr/bin/head -n 1
  )"
fi

if [[ -z "$device_id" ]]; then
  device_id="$(
    /usr/bin/xcrun simctl list devices available |
      /usr/bin/sed -nE '/iPhone/ s/.*\(([0-9A-F-]{36})\) \((Booted|Shutdown)\).*/\1/p' |
      /usr/bin/head -n 1
  )"
fi

if [[ -z "$device_id" ]]; then
  print -u2 "利用可能なiPhone Simulatorが見つかりません。"
  exit 1
fi

if ! /usr/bin/xcrun simctl list devices available | /usr/bin/grep -q "$device_id"; then
  print -u2 "指定されたSimulatorが見つかりません: $device_id"
  exit 1
fi

if ! /usr/bin/xcrun simctl list devices booted | /usr/bin/grep -q "$device_id"; then
  /usr/bin/xcrun simctl boot "$device_id" >&2
fi

/usr/bin/xcrun simctl bootstatus "$device_id" -b >&2
/usr/bin/open -a Simulator

print -r -- "$device_id"
