# bin/

Helper scripts plus the `dot` CLI. Everything here is added to `$PATH` by the Makefile (`PATH := $(DOTFILES_DIR)/bin:$(PATH)`) so Makefile recipes can invoke these scripts without absolute paths.

## Helpers

| Script | Purpose |
| --- | --- |
| `is-executable <cmd>` | Exit 0 if `cmd` is on `$PATH`, else 1 |
| `is-macos` | Exit 0 on macOS (checks `$OSTYPE`) |
| `is-supported <test> [yes] [no]` | Eval `test`; with 1 arg, exit 0/1; with 3 args, echo `yes` or `no` |
| `append <line> <file>` | Append `line` to `file` if not already present (idempotent via `pcregrep -M`) |
| `plistbuddy <plist> <action> <key> [value]` | Wrapper around `/usr/libexec/PlistBuddy` against `~/Library/Preferences/<plist>.plist` |

## The `dot` CLI

`dot help` for the surface. Subcommands:

| Subcommand | Action |
| --- | --- |
| `dot clean` | `brew cleanup`, `gem cleanup` |
| `dot dock` | Apply `macos/dock.sh` |
| `dot edit` | Open the dotfiles in `$DOTFILES_IDE` and `$DOTFILES_GIT_GUI` |
| `dot macos` | Source every `macos/defaults*.sh` |
| `dot test` | Run `shellcheck` on tracked scripts then `bats` on `tests/` |
| `dot update` | `softwareupdate -i -a`, `brew update`/`upgrade`/`cleanup`, `gem update --system`, `gem update` |

`dot` resolves the dotfiles directory via `$DOTFILES_DIR` (set by the user's shell init) or falls back to `dirname "$(dirname "$0")"`.

Each `bin/*` script has a corresponding `tests/*.bats` file (except `dot` whose tests cover dispatch + help).
