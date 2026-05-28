# dotfiles

@irmiller22 does dotfiles.

## Install

On a sparkling fresh installation of OS X:

    sudo softwareupdate -i -a
    xcode-select --install

Install the dotfiles with either Git or curl. The repo **must** live at
`~/.dotfiles` — the Makefile enforces this and the install scripts
assume it.

### Clone with Git

    git clone https://github.com/irmiller22/dotfiles.git ~/.dotfiles
    cd ~/.dotfiles
    make all

### Remotely install using curl

Alternatively, you can install this into `~/.dotfiles` remotely without
Git using curl, then run `make` from the resulting directory:

    sh -c "`curl -fsSL https://raw.githubusercontent.com/irmiller22/dotfiles/master/remote-install.sh`"
    cd ~/.dotfiles && make all

Or, using wget:

    sh -c "`wget -O - --no-check-certificate https://raw.githubusercontent.com/irmiller22/dotfiles/master/remote-install.sh`"
    cd ~/.dotfiles && make all

## The `dot` command

    $ dot help
    Usage: dot <command>

    Commands:
       clean            Clean up caches (brew, gem)
       dock             Apply macOS Dock settings
       edit             Open dotfiles in IDE ($DOTFILES_IDE) and Git GUI ($DOTFILES_GIT_GUI)
       help             This help message
       macos            Apply macOS system defaults
       test             Run shellcheck and bats tests
       update           Update packages and pkg managers (OS, brew, gem)

See [`bin/README.md`](./bin/README.md) for the helper scripts that back the CLI, and [`CLAUDE.md`](./CLAUDE.md) for the repo's conventions and constraints.

## Additional resources

* [Awesome Dotfiles](https://github.com/webpro/awesome-dotfiles)
* [Homebrew](http://brew.sh/) / [FAQ](https://github.com/Homebrew/homebrew/wiki/FAQ)
* [homebrew-cask](http://caskroom.io/) / [usage](https://github.com/phinze/homebrew-cask/blob/master/USAGE.md)
* [Bash prompt](http://wiki.archlinux.org/index.php/Color_Bash_Prompt)
* [Solarized Color Theme for GNU ls](https://github.com/seebi/dircolors-solarized)

## Credits

Many thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators of the incredibly useful tools. Huge props to @webpro for this.
