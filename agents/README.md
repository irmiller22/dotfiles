# Agent instructions

This directory is the source of truth for user-level engineering guidance shared
by Claude Code and Codex.

```text
agents/
├── shared/guidelines/  # canonical rules with no tool-specific paths
├── claude/CLAUDE.md    # Claude Code loader and Claude-specific configuration guidance
└── codex/AGENTS.md     # Codex loader and Codex-specific configuration guidance
```

Do not duplicate shared guidance in the two loader files. Put a rule in a loader
only when it describes that tool's discovery, precedence, permissions, or
configuration behavior.

`make link` invokes `bin/link-agent-config link`. It links both tools' guideline
directories to `shared/guidelines/`, so an edit to a shared rule applies to both
tools. The linker refuses to overwrite unmanaged paths. `make unlink` removes
only links owned by this repository.

Claude expands the `@guidelines/...` references in its loader. Codex does not,
so its loader explicitly tells Codex which files to read and when.

Machine-specific runtime configuration is out of scope. In particular,
`~/.claude/settings.json` and `~/.codex/config.toml` are not linked because the
tools and local integrations may update them independently.
