#!/usr/bin/env bats

load test_helper

@test "dot: --help lists known commands" {
  run dot --help
  [ "$status" -eq 0 ]
  [[ "$output" == *"clean"* ]]
  [[ "$output" == *"dock"* ]]
  [[ "$output" == *"macos"* ]]
  [[ "$output" == *"test"* ]]
  [[ "$output" == *"update"* ]]
}

@test "dot: bare invocation shows help" {
  run dot
  [ "$status" -eq 0 ]
  [[ "$output" == *"Usage:"* ]]
}

@test "dot: unknown subcommand exits 1 with error message" {
  run dot definitely-not-a-real-subcommand
  [ "$status" -eq 1 ]
  [[ "$output" == *"not a known command"* ]]
}
