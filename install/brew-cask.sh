# Install Caskroom
brew tap caskroom/cask
brew tap caskroom/versions

# Install packages
apps=(
  1password
  alfred
  dash
  dropbox
  firefox
  google-chrome
  google-chrome-canary
  google-drive
  kindle
  macdown
  postgres
  sqlpro-for-postgres
  slate
  slack
  sublime-text3
  tunnelblick
  virtualbox
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzipql qlimagesize webpquicklook suspicious-package
