#!/usr/bin/env bash
# Common setup for bats tests — load via `load test_helper` in *.bats files.

DOTFILES_DIR="$(cd "$(dirname "$BATS_TEST_FILENAME")/.." && pwd)"
export DOTFILES_DIR
export PATH="$DOTFILES_DIR/bin:$PATH"
