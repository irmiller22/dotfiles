# User-level instructions

Cross-project guidance Claude Code should apply by default. Project-level
`CLAUDE.md` files in a working directory take precedence over anything here
when they conflict.

## Organization

Domain-specific guidance lives in its own file under `~/.claude/guidelines/`
and is referenced from this file via `@guidelines/<topic>.md` imports. Keep
each file focused on a single domain so it can be revised independently.
When adding new guidance, prefer creating a new `guidelines/<topic>.md`
file over inlining content here.

## Guidelines

- @guidelines/general-engineering.md — language-independent correctness, simplicity, scope, dependency, naming, and verification standards. Read it before changing or reviewing code in any repository.
- @guidelines/typescript-nextjs.md — TypeScript, React, browser, and Next.js standards. Read it before changing or reviewing code in those domains.
- @guidelines/interview.md — language-independent standards for technical interview exercises. Read it when the task is an interview exercise.
- @guidelines/python.md — Python testing, DAO/DTO architecture, ruff linting, type checking, FastAPI/SQLAlchemy idioms, and idiomatic-Python standards
- @guidelines/design-docs.md — keeping design documents in sync with implementation: contract-change discipline, derived-vs-stored, drift audits
- @guidelines/repository-context.md — discovering and preserving a repository's canonical architecture, conventions, runbooks, and decisions. Read it before planning substantial changes in an unfamiliar repository or introducing a capability with no established precedent.
- @guidelines/autonomy.md — cross-project authority boundaries, autonomous action defaults, checkpoints, retry discipline, and stop conditions. Read it for sustained or multi-step work and whenever the user asks Claude Code to proceed with minimal feedback.

## Permissions: global vs project-local

Claude Code merges this user-level `~/.claude/settings.json` with each repo's
`.claude/settings.local.json`. Keep them split along these lines:

- **Global (`~/.claude/settings.json`)** — anything safe in *any* repo:
  - Destructive `deny` rules (`git push --force`/`--force-with-lease`,
    `git reset --hard`, `git checkout -- *`, `git restore --worktree`,
    `git clean -f`, `gh pr merge`, `rm -rf`). These are universal — never wanted
    from any project.
  - Read-only allows (`gh pr view`/`checks`/`diff`, `shellcheck`, `bats`,
    `find`, `grep`, Linear `list_*`/`get_*`) — harmless everywhere.
  - Local git + branch/PR ops (`add`, `commit`, `checkout`, `branch`, `switch`,
    `push -u origin`, `gh pr create`) — reviewable via diff and the PR workflow;
    `gh pr merge` stays denied so merge gatekeeping is retained.
  - Blanket `Write`/`Edit` and Linear `save_issue` — kept global to support
    semi-autonomous work; git history and diff review are the safety net.
- **Project-local (`.claude/settings.local.json`)** — repo-specific tooling and
  anything coupled to one toolchain/workspace (e.g. a repo's own CLI like
  `bin/dot`). Doesn't generalize, so it stays out of the global file.
