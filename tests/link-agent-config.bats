#!/usr/bin/env bats

load test_helper

setup() {
  TEST_HOME="$BATS_TEST_TMPDIR/home"
  mkdir -p "$TEST_HOME"
}

@test "link-agent-config: links shared guidance for Claude and Codex idempotently" {
  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" link
  [ "$status" -eq 0 ]

  [ "$(readlink "$TEST_HOME/.claude/CLAUDE.md")" = "$DOTFILES_DIR/agents/claude/CLAUDE.md" ]
  [ "$(readlink "$TEST_HOME/.claude/guidelines")" = "$DOTFILES_DIR/agents/shared/guidelines" ]
  [ "$(readlink "$TEST_HOME/.codex/AGENTS.md")" = "$DOTFILES_DIR/agents/codex/AGENTS.md" ]
  [ "$(readlink "$TEST_HOME/.codex/guidelines")" = "$DOTFILES_DIR/agents/shared/guidelines" ]

  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" link
  [ "$status" -eq 0 ]
}

@test "link-agent-config: refuses unmanaged paths without partially linking" {
  mkdir -p "$TEST_HOME/.claude"
  touch "$TEST_HOME/.claude/CLAUDE.md"

  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" link
  [ "$status" -eq 1 ]
  [[ "$output" == *"Refusing to replace unmanaged path"* ]]
  [ ! -e "$TEST_HOME/.codex/AGENTS.md" ]
  [ ! -L "$TEST_HOME/.codex/AGENTS.md" ]
}

@test "link-agent-config: unlinks only repository-owned links" {
  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" link
  [ "$status" -eq 0 ]

  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" unlink
  [ "$status" -eq 0 ]
  [ ! -L "$TEST_HOME/.claude/CLAUDE.md" ]
  [ ! -L "$TEST_HOME/.claude/guidelines" ]
  [ ! -L "$TEST_HOME/.codex/AGENTS.md" ]
  [ ! -L "$TEST_HOME/.codex/guidelines" ]

  ln -s "$BATS_TEST_TMPDIR/elsewhere" "$TEST_HOME/.claude/CLAUDE.md"
  run env HOME="$TEST_HOME" "$DOTFILES_DIR/bin/link-agent-config" unlink
  [ "$status" -eq 0 ]
  [ -L "$TEST_HOME/.claude/CLAUDE.md" ]
}
