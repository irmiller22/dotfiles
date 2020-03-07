# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

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

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
