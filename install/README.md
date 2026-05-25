# install/

Prescriptive manifests for what should be installed on a fresh machine. Each file is consumed by a corresponding `make` target:

| File | Consumer | Purpose |
| --- | --- | --- |
| `Brewfile` | `make brew-packages` (via `brew bundle`) | Homebrew formulae |
| `Brewfile.lock.json` | (auto-managed by `brew bundle`) | Lockfile |
| `Caskfile` | `make cask-apps` (via `brew bundle`) | Homebrew casks (GUI apps) |
| `Gemfile` | (currently unused) | Ruby gems |
| `npmfile` | (no make target yet) | Global npm packages |

## These are prescriptive, not descriptive

When the live machine and a manifest diverge, the question is **per-tool curation**: "if I rebuilt this machine tomorrow, do I want this installed?" Don't shrink the manifests just because the current machine doesn't have something, and don't pad them with one-off tools that aren't worth re-installing.

## Known stale references

`Makefile`'s `cask-apps` target also reads `install/Codefile` (for VSCode extensions) — but that file no longer exists. The line is dead and needs to be either removed or `Codefile` needs to be re-created. Tracked separately from these docs.
