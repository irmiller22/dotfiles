# install/

Prescriptive manifests for what should be installed on a fresh machine. Each file is consumed by a corresponding `make` target:

| File | Consumer | Purpose |
| --- | --- | --- |
| `Brewfile` | `make brew-packages` (via `brew bundle`) | Homebrew formulae |
| `Brewfile.lock.json` | (auto-managed by `brew bundle`) | Lockfile |
| `Caskfile` | `make cask-apps` (via `brew bundle`) | Homebrew casks (GUI apps) |
| `Codefile` | `make cask-apps` (via `code --install-extension`) | VSCode extensions |
| `Gemfile` | (currently unused) | Ruby gems |
| `npmfile` | (no make target yet) | Global npm packages |

## These are prescriptive, not descriptive

When the live machine and a manifest diverge, the question is **per-tool curation**: "if I rebuilt this machine tomorrow, do I want this installed?" Don't shrink the manifests just because the current machine doesn't have something, and don't pad them with one-off tools that aren't worth re-installing.
