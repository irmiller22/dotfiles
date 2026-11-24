#!/usr/bin/env bats

load test_helper

setup() {
  PACKAGE="$BATS_TEST_TMPDIR/package"
  TARGET="$BATS_TEST_TMPDIR/target"
  mkdir -p "$PACKAGE/nested" "$TARGET"
  echo repo > "$PACKAGE/.zshrc"
  echo repo > "$PACKAGE/nested/file"
}

@test "backup-stow-conflicts: moves conflicting regular files aside" {
  echo existing > "$TARGET/.zshrc"

  run backup-stow-conflicts "$PACKAGE" "$TARGET"
  [ "$status" -eq 0 ]
  [[ "$output" == *"Backed up $TARGET/.zshrc"* ]]
  [ ! -e "$TARGET/.zshrc" ]
  [ "$(cat "$TARGET/.zshrc.pre-dotfiles")" = existing ]
}

@test "backup-stow-conflicts: handles nested files inside existing directories" {
  mkdir -p "$TARGET/nested"
  echo existing > "$TARGET/nested/file"

  run backup-stow-conflicts "$PACKAGE" "$TARGET"
  [ "$status" -eq 0 ]
  [ -d "$TARGET/nested" ]
  [ "$(cat "$TARGET/nested/file.pre-dotfiles")" = existing ]
}

@test "backup-stow-conflicts: leaves symlinks and missing targets alone" {
  ln -s "$PACKAGE/.zshrc" "$TARGET/.zshrc"

  run backup-stow-conflicts "$PACKAGE" "$TARGET"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ -L "$TARGET/.zshrc" ]
  [ ! -e "$TARGET/.zshrc.pre-dotfiles" ]
}

@test "backup-stow-conflicts: never moves files through a stow-folded directory link" {
  ln -s "$PACKAGE/nested" "$TARGET/nested"

  run backup-stow-conflicts "$PACKAGE" "$TARGET"
  [ "$status" -eq 0 ]
  [ -z "$output" ]
  [ "$(cat "$PACKAGE/nested/file")" = repo ]
  [ ! -e "$PACKAGE/nested/file.pre-dotfiles" ]
}

@test "backup-stow-conflicts: never overwrites an earlier backup" {
  echo first > "$TARGET/.zshrc.pre-dotfiles"
  echo second > "$TARGET/.zshrc"

  run backup-stow-conflicts "$PACKAGE" "$TARGET"
  [ "$status" -eq 0 ]
  [ "$(cat "$TARGET/.zshrc.pre-dotfiles")" = first ]
  [ "$(cat "$TARGET"/.zshrc.pre-dotfiles.*)" = second ]
}

@test "backup-stow-conflicts: rejects wrong arguments" {
  run backup-stow-conflicts "$PACKAGE"
  [ "$status" -eq 2 ]
}
