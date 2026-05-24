#!/usr/bin/env bats

load test_helper

setup() {
  TMPFILE="$(mktemp)"
}

teardown() {
  rm -f "$TMPFILE"
}

@test "append: adds a new line when not present" {
  echo "existing line" > "$TMPFILE"
  run append "new line" "$TMPFILE"
  [ "$status" -eq 0 ]
  grep -qx "new line" "$TMPFILE"
}

@test "append: is idempotent when the line is already present" {
  echo "already here" > "$TMPFILE"
  run append "already here" "$TMPFILE"
  [ "$status" -eq 0 ]
  [ "$(grep -cx "already here" "$TMPFILE")" -eq 1 ]
}

@test "append: running twice for the same new line keeps only one occurrence" {
  echo "first" > "$TMPFILE"
  run append "second" "$TMPFILE"
  run append "second" "$TMPFILE"
  [ "$status" -eq 0 ]
  [ "$(grep -cx "second" "$TMPFILE")" -eq 1 ]
}
