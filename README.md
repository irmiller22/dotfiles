# dotfiles

@irmiller22 does dotfiles.

## Install

On a fresh installation of OS X:

```sh
sudo softwareupdate -i -a
xcode-select --install
```

Install the dotfiles with Git:

```sh
git clone https://github.com/holman/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
```

Once installed, then you can bootstrap the dotfiles:

```sh
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.

`dot` is a simple script that installs some dependencies, sets sane macOS
defaults, and so on. Tweak this script, and occasionally run `dot` from
time to time to keep your environment fresh and up-to-date. You can find
this script in `bin/`.

## Components

This takes the majority of its inspiration from how @holman sets up his [dotfiles](https://github.com/holman/dotfiles):

- **bin/**: Anything in `bin/` will get added to your `$PATH` and be made
  available everywhere.
- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/completion.zsh**: Any file named `completion.zsh` is loaded
  last and is expected to setup autocomplete.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## Special Thanks

I forked [Zach Holman](http://github.com/holman)'s excellent
[dotfiles](http://github.com/holman/dotfiles) and provides the foundation for my
dotfiles. I've customized his implementation to suit my own needs, but many
thanks to @holman for providing a simple and maintainable approach to dotfiles.
