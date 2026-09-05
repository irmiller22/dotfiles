SHELL = /bin/sh
DOTFILES_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))
OS := $(shell bin/is-supported bin/is-macos macos linux)
PATH := $(DOTFILES_DIR)/bin:$(PATH)
export XDG_CONFIG_HOME = $(HOME)/.config
export STOW_DIR = $(DOTFILES_DIR)
export ACCEPT_EULA=Y

# Enforce canonical install location. CI checks out to a non-canonical path,
# so the guard is bypassed there.
ifndef GITHUB_ACTION
ifneq ($(DOTFILES_DIR),$(HOME)/.dotfiles)
$(error Dotfiles must be installed at $$HOME/.dotfiles, found $(DOTFILES_DIR). See README.)
endif
endif

.PHONY: test

all: $(OS)

macos: sudo core-macos packages omz link

linux: core-linux omz link

core-macos: brew git ruby

core-linux:
	apt-get update
	apt-get upgrade -y
	apt-get dist-upgrade -f

stow-macos: brew
	is-executable stow || brew install stow

stow-linux: core-linux
	is-executable stow || apt-get -y install stow

sudo:
ifndef GITHUB_ACTION
	sudo -v
	while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
endif

packages: brew-packages cask-apps

omz:
	bin/install-oh-my-zsh

link: stow-$(OS)
	mkdir -p $(XDG_CONFIG_HOME)
	stow -t $(XDG_CONFIG_HOME) config
	stow -t $(HOME) zsh

unlink: stow-$(OS)
	stow --delete -t $(XDG_CONFIG_HOME) config
	stow --delete -t $(HOME) zsh

brew:
	is-executable brew || curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash

git: brew
	brew install git git-extras

ruby: brew
	brew install ruby

gcloud-auth:
	is-executable gcloud || (echo "gcloud is not installed"; exit 1)
	gcloud auth login
	gcloud auth application-default login

brew-packages: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Brewfile

cask-apps: brew
	brew bundle --file=$(DOTFILES_DIR)/install/Caskfile || true
	defaults write org.hammerspoon.Hammerspoon MJConfigFile "~/.config/hammerspoon/init.lua"
	for EXT in $$(cat install/Codefile); do code --install-extension $$EXT; done
