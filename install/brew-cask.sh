# Install Caskroom
brew tap homebrew/cask
brew tap homebrew/cask-versions

# Install packages
apps=(
  1password6
  alfred
  dash
  docker
  dropbox
  firefox
  google-drive
  iterm2
  keybase
  kindle
  postgres
  sqlpro-for-mysql
  sqlpro-for-postgres
  slate
  slack
  sublime-text3
  tunnelblick
  vagrant
  virtualbox
)

brew install --cask "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
