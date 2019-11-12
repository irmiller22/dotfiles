# Install Caskroom
brew tap homebrew/cask-cask
brew tap homebrew/cask-versions

# Install packages
apps=(
  1password
  alfred
  dash
  dropbox
  firefox
  iterm2
  kindle
  macdown
  postgres
  sqlpro-for-mysql
  sqlpro-for-postgres
  slate
  slack
  sublime-text3
  tunnelblick
  virtualbox
)

brew cask install "${apps[@]}"

# Quick Look Plugins (https://github.com/sindresorhus/quick-look-plugins)
brew cask install qlcolorcode qlstephen qlmarkdown quicklook-json qlprettypatch quicklook-csv betterzip qlimagesize webpquicklook suspicious-package
