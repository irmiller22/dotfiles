#!/usr/bin/env bats

load test_helper

@test "is-macos: returns 0 when run on macOS" {
  if [[ "$OSTYPE" != darwin* ]]; then
    skip "not on macOS"
  fi
  run is-macos
  [ "$status" -eq 0 ]
}
