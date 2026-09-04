#!/usr/bin/env bats

load test_helper

setup() {
  TMP_HOME="$(mktemp -d)"
  export TMP_HOME
  export ZSH="$TMP_HOME/.oh-my-zsh"
  export ZSH_CUSTOM="$ZSH/custom"
  mkdir -p "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
  mkdir -p "$ZSH_CUSTOM/plugins/zsh-completions"
}

teardown() {
  rm -rf "$TMP_HOME"
}

@test "install-oh-my-zsh: no-ops when oh-my-zsh and plugins already present" {
  run install-oh-my-zsh
  [ "$status" -eq 0 ]
  [[ "$output" != *"Installing oh-my-zsh"* ]]
  [[ "$output" != *"Installing zsh-autosuggestions"* ]]
  [[ "$output" != *"Installing zsh-completions"* ]]
}

@test "install-oh-my-zsh: clones a missing plugin but leaves an existing one alone" {
  rm -rf "${ZSH_CUSTOM:?}/plugins/zsh-completions"
  run install-oh-my-zsh
  [ "$status" -eq 0 ]
  [[ "$output" != *"Installing zsh-autosuggestions"* ]]
  [[ "$output" == *"Installing zsh-completions"* ]]
  [ -d "$ZSH_CUSTOM/plugins/zsh-completions/.git" ]
}

@test "install-oh-my-zsh: symlinks custom theme overrides from the repo" {
  run install-oh-my-zsh
  [ "$status" -eq 0 ]
  [ -L "$ZSH_CUSTOM/themes/agnoster.zsh-theme" ]
  diff "$ZSH_CUSTOM/themes/agnoster.zsh-theme" "$DOTFILES_DIR/oh-my-zsh-custom/themes/agnoster.zsh-theme"
}
