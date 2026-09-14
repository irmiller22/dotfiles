export DOTFILES_DIR="$HOME/.dotfiles"
export DOTFILES="$HOME/.dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"

# Keep $PATH free of duplicates. The prepends below are unconditional, so nested
# login shells would otherwise stack repeated entries.
typeset -U path PATH

PATH="$DOTFILES_DIR/bin:$PATH"
PATH="/opt/homebrew/bin:$PATH"
export PATH

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi

# ORDERING: this file runs BEFORE .zshrc, and therefore before oh-my-zsh runs
# compinit. Anything that calls `compdef` (i.e. any completion script) must be
# sourced from .zshrc or .profile instead, both of which run after compinit.
#
# Three things used to be sourced here and were moved for that reason:
#   - ~/.profile — now sourced from .zshrc only. It loads kubectl's completion,
#     which calls compdef; running it here printed "command not found: compdef"
#     on every shell, and re-sourcing duplicated PATH entries.
#   - ~/.git-completion.zsh — dropped entirely. Homebrew's git ships zsh's native
#     _git into $HOMEBREW_PREFIX/share/zsh/site-functions, which is on FPATH above,
#     so compinit finds it automatically. Nothing in this repo installed the file.
#   - ~/.kubectl_aliases — now sourced only from .profile, which is also what
#     downloads it on a fresh machine.
