# Install Caskroom
brew tap homebrew/cask
brew tap homebrew/cask-versions

# Install packages
apps=(
  1password6
  alfred
  dash
  docker
  iterm2
  keybase
  kindle
  postgres
  sqlpro-for-mysql
  sqlpro-for-postgres
  slate
  tunnelblick
  vagrant
  virtualbox
)

brew install --cask "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew install --cask qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv qlimagesize webpquicklook suspicious-package
