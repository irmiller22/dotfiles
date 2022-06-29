[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.bash.inc"
[[ -s "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc" ]] && source "/usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.bash.inc"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v direnv 1>/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

if command -v kubectl 1>/dev/null 2>&1; then
  eval "source <(kubectl completion bash)"
  alias kgnsi='k config set-context --current --namespace=$(kg ns -o json | jq -r ".items[].metadata.name"| fzf)'
  test -e "${HOME}/.kubectl_aliases" && source "${HOME}/.kubectl_aliases"
fi

if command -v kubectl 1>/dev/null 2>&1; then
  function kdecsec() {
    kubectl get secret $1 -o jsonpath="{.data}" | jq '.[] |= @base64d'
  }
fi

# Load work configurations
test -e "${HOME}/.seismic" && source "${HOME}/.seismic"
