[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"

# Direnv
if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# K8S
if command -v kubectl 1>/dev/null 2>&1; then
  eval "source <(kubectl completion zsh)"
  alias kgnsi='k config set-context --current --namespace=$(kg ns -o json | jq -r ".items[].metadata.name"| fzf)'
  test -e "${HOME}/.kubectl_aliases" && source "${HOME}/.kubectl_aliases"
fi

if command -v kubectl 1>/dev/null 2>&1; then
  function kdecsec() {
    kubectl get secret $1 -o jsonpath="{.data}" | jq '.[] |= @base64d'
  }
fi

# Seismic - Load work configurations
test -e "${HOME}/.seismic" && source "${HOME}/.seismic"

# RVM
export PATH="$PATH:$HOME/.rvm/bin"

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
