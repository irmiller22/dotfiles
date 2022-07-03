# If not running interactively, don't do anything
[ -z "$PS1" ] && return

autoload -Uz compinit && compinit

# Resolve DOTFILES_DIR (assuming ~/.dotfiles on distros without readlink and/or $BASH_SOURCE/$0)

READLINK=$(which greadlink 2>/dev/null || which readlink)
CURRENT_SCRIPT=$BASH_SOURCE

if [[ -n $CURRENT_SCRIPT && -x "$READLINK" ]]; then
  SCRIPT_PATH=$($READLINK -f "$CURRENT_SCRIPT")
  DOTFILES_DIR=$(dirname "$(dirname "$SCRIPT_PATH")")
elif [ -d "$HOME/.dotfiles" ]; then
  DOTFILES_DIR="$HOME/.dotfiles"
else
  echo "Unable to find dotfiles, exiting."
  return
fi

# Make utilities available

PATH="$DOTFILES_DIR/bin:$PATH"

# Source the dotfiles (order matters)

for DOTFILE in "$DOTFILES_DIR"/system/.{function,function_*,path,env,alias,grep,prompt,completion,fix,custom}; do
  [ -f "$DOTFILE" ] && . "$DOTFILE"
done

if is-macos; then
  for DOTFILE in "$DOTFILES_DIR"/system/.{env,alias,function,path}.macos; do
    [ -f "$DOTFILE" ] && . "$DOTFILE"
  done
fi

if [ ! -f "$HOME/.slate" ]; then
  cp "$DOTFILES_DIR"/system/.slate "$HOME"/.slate
fi

# Bash Completion
if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]; then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*; do
      [[ -r "$COMPLETION" ]] && source "$COMPLETION"
    done
  fi

    # Git completion aliases
  # __git_complete g __git_main
  # __git_complete gco _git_checkout
  # __git_complete gp _git_pull
  # __git_complete gb _git_branch
  # __git_complete gbd _git_branch -D
fi

# Git Completion
if [ -f "$HOME"/.git-completion.zsh ]; then
  . "$HOME"/.git-completion.zsh
fi

# Hook for extra/custom stuff
DOTFILES_EXTRA_DIR="$HOME/.extra"

if [ -d "$DOTFILES_EXTRA_DIR" ]; then
  for EXTRAFILE in "$DOTFILES_EXTRA_DIR"/runcom/*.sh; do
    [ -f "$EXTRAFILE" ] && . "$EXTRAFILE"
  done
fi

# Clean up
unset READLINK CURRENT_SCRIPT SCRIPT_PATH DOTFILE EXTRAFILE

# Export
export DOTFILES_DIR DOTFILES_EXTRA_DIR

# XDG Config
export XDG_CONFIG_HOME=/Users/imiller/.config

# iterm2 integration
if command -v brew 1>/dev/null 2>&1; then
  function iterm2_print_user_vars() {
    iterm2_set_user_var kubecontext $(kubectl config current-context)
  }
fi

test -e "${HOME}/.git-completion.zsh" && source "${HOME}/.git-completion.zsh"
test -e "${HOME}/.kubectl_aliases" && source "${HOME}/.kubectl_aliases"
test -e "${HOME}/.profile" && source "${HOME}/.profile"
