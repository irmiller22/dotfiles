# CLAUDE.md

Orientation for Claude Code sessions working in this repo.

## What this repo is

Personal dotfiles for `irmiller22`. Two layers:

1. **System config** (`config/`, `macos/`) — versioned, declarative, applied via `make`
2. **Tooling manifests** (`install/`, `bin/`) — what should be installed on a fresh machine, plus helper CLIs

Shell init (`~/.zshrc`, `~/.zprofile`) is **NOT** in this repo — it is hand-maintained per machine. The `runcom/` and `system/` directories were deleted on purpose (LAT-32). Do not suggest adding them back.

## Canonical install location

The repo **must** live at `~/.dotfiles`. The `Makefile` has a guard that errors out if `$(DOTFILES_DIR) != $HOME/.dotfiles`. The guard is bypassed when `$GITHUB_ACTION` is set so CI runs work.

If you spawn a sub-agent in a worktree (which lives at a different path), do not run `make` from there — it will refuse. Use direct file editing instead.

## Install flow

| Command | What it does |
| --- | --- |
| `make all` | Full install: Homebrew, Brewfile, Caskfile, then `make link` |
| `make link` | Stow `config/` → `$XDG_CONFIG_HOME` (typically `~/.config`) |
| `make unlink` | Reverse of `make link` |
| `make brew-packages` | Install/update from `install/Brewfile` |
| `make cask-apps` | Install/update from `install/Caskfile` (and VSCode extensions) |

The README (and earlier templates) referred to an `install.sh` — that file never existed. The Makefile is the only entry point.

## Directories

- **`bin/`** — Helper scripts (`is-executable`, `is-macos`, `is-supported`, `append`, `plistbuddy`) and the `dot` CLI. Anything Makefile recipes need lives here.
- **`config/`** — Stowed to `$XDG_CONFIG_HOME`. Currently `config/git/` and `config/prettier/`.
- **`install/`** — Prescriptive install manifests (see "Install manifests are prescriptive" below).
- **`macos/`** — `defaults.sh` (~448 lines of `defaults write …` commands) and `dock.sh`. Applied via `dot macos` and `dot dock`.
- **`tests/`** — `bats` tests for the `bin/` helpers and the `dot` CLI.
- **`.github/workflows/`** — CI: shellcheck + bats job, plus a `make link` smoke-test job.

## Install manifests are prescriptive

`install/Brewfile`, `install/Caskfile`, `install/Gemfile`, `install/npmfile` declare what **should** be installed on a fresh machine — not what currently is. When the live machine and a manifest diverge, the question is **per-tool curation**: "if I rebuilt this machine tomorrow, do I want this installed?"

Don't shrink the manifests just because the current machine doesn't have something. Don't pad them with one-off tools that aren't worth re-installing.

## Testing

```sh
bin/dot test
```

Runs `shellcheck` on `bin/*`, `macos/*.sh`, `osxdefaults.sh`, `remote-install.sh`, then `bats` on `tests/*.bats`. CI runs the same command on every push to `master` and every PR.

If you add or modify a `bin/` script, shellcheck must pass. If you add user-facing behavior, add a bats test.

## Workflow conventions

- **Never** commit directly to `master` and push. Always:
  1. Branch from `master` with a descriptive kebab-case name
  2. Commit with HEREDOC messages ending with the standard `Co-Authored-By: Claude …` trailer
  3. Push the branch
  4. `gh pr create --base master …`
  5. Merge only when CI is green and the user approves
- Linear ticket IDs (`LAT-NN`) are referenced from commit messages and PR descriptions when applicable.
- Background agents in worktrees currently can't perform mutating operations — if delegating implementation, expect to take over the actual edits/commits from the main session.

## Things that look like bugs but are intentional

- `~/.zshrc` is a regular file (not a symlink). Per-machine shell init is hand-maintained.
- `config/git` and `config/prettier` are the only items under `config/`. That's the entire stow scope.
- Some `install/` manifests list tools that aren't installed on the current machine. They're prescriptive; that's expected.
