#!/usr/bin/env bats

load test_helper

@test "plistbuddy: silently no-ops when the target plist does not exist" {
  run plistbuddy com.example.no-such-plist-xyz123 Print :NonExistent
  [ "$status" -eq 0 ]
  [ -z "$output" ]
}

@test "plistbuddy: reads a key from an existing plist" {
  TMPHOME="$(mktemp -d)"
  mkdir -p "$TMPHOME/Library/Preferences"
  PLIST_PATH="$TMPHOME/Library/Preferences/com.example.test.plist"
  /usr/libexec/PlistBuddy -c "Add :TestKey string TestValue" "$PLIST_PATH" >/dev/null

  HOME="$TMPHOME" run plistbuddy com.example.test Print :TestKey
  rm -rf "$TMPHOME"

  [ "$status" -eq 0 ]
  [ "$output" = "TestValue" ]
}
