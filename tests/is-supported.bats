#!/usr/bin/env bats

load test_helper

@test "is-supported: one-arg success exits 0" {
  run is-supported "true"
  [ "$status" -eq 0 ]
}

@test "is-supported: one-arg failure exits 1" {
  run is-supported "false"
  [ "$status" -eq 1 ]
}

@test "is-supported: three-arg success echoes the yes value" {
  run is-supported "true" "yes" "no"
  [ "$status" -eq 0 ]
  [ "$output" = "yes" ]
}

@test "is-supported: three-arg failure echoes the no value" {
  run is-supported "false" "yes" "no"
  [ "$status" -eq 0 ]
  [ "$output" = "no" ]
}
