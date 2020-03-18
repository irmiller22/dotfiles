# Install Homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew upgrade

# Install packages
apps=(
  bash-completion2
  bats
  coreutils
  cmake
  dockutil
  ffmpeg
  fasd
  gifsicle
  git
  gnu-sed
  grep
  hub
  httpie
  imagemagick
  jq
  node
  peco
  poetry
  psgrep
  python
  shellcheck
  ssh-copy-id
  svn
  tree
  vim
  wget
  wifi-password
)

brew install "${apps[@]}"

export DOTFILES_BREW_PREFIX_COREUTILS=`brew --prefix coreutils`
set-config "DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_BREW_PREFIX_COREUTILS" "$DOTFILES_CACHE"
