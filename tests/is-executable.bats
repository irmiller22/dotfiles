#!/usr/bin/env bats

load test_helper

@test "is-executable: returns 0 for a known shell builtin / command (ls)" {
  run is-executable ls
  [ "$status" -eq 0 ]
}

@test "is-executable: returns 1 for a nonexistent command" {
  run is-executable definitely-not-a-real-command-xyz123
  [ "$status" -eq 1 ]
}

@test "is-executable: returns 1 when given no argument" {
  run is-executable
  [ "$status" -eq 1 ]
}
