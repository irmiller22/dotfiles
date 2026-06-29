export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="agnoster"

zstyle ':completion:*' completer _complete _ignored _files _expand_alias

plugins=(git shrink-path zsh-autosuggestions)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src
source $ZSH/oh-my-zsh.sh

source ~/.profile
