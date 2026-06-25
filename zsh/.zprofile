export DOTFILES_DIR="$HOME/.dotfiles"
export DOTFILES="$HOME/.dotfiles"
export XDG_CONFIG_HOME="$HOME/.config"

PATH="$DOTFILES_DIR/bin:$PATH"
export PATH

autoload -Uz compinit && compinit

if type brew &>/dev/null; then
  HOMEBREW_PREFIX="$(brew --prefix)"
  FPATH="${HOMEBREW_PREFIX}/share/zsh/site-functions:${FPATH}"
fi

test -e "${HOME}/.git-completion.zsh" && source "${HOME}/.git-completion.zsh"
test -e "${HOME}/.kubectl_aliases" && source "${HOME}/.kubectl_aliases"

source "$DOTFILES_DIR/zsh/.profile"
