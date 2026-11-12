# Repository context and entropy control

Use this guidance before planning substantial changes in an unfamiliar
repository or introducing a capability with no established precedent. The goal
is to preserve one coherent system across many human and agent contributors.
Do not require new documentation for trivial, local changes.

## Find the canonical context first

- Discover applicable instruction files, architecture documents, conventions,
  runbooks, decision records, tests, and relevant history before designing the
  change.
- Prefer the repository's documented canonical pattern over a novel solution
  that merely works. When examples conflict, investigate which pattern is
  current and intended; do not add a third pattern by default.
- If the canonical choice remains materially ambiguous, surface the conflict
  and the decision required. Otherwise choose the narrowest established
  pattern and record the assumption.
- For review-only or diagnostic work, report missing or conflicting context.
  Do not create or modify documentation without authorization to change the
  repository.

## Use four focused forms of context

### Architecture

For a significant capability the repository has not had before, establish or
update the architecture before implementation. Keep it compact and include:

- The system idea in one sentence.
- What each component owns and must not own.
- The principal flow and important failure modes.
- The few decisions that would be costly to reverse.
- Links to related documents instead of repeated prose.

### Conventions

Make conventions concise and review-enforceable. A useful convention states
the rule, the non-obvious reason, a correct example, the rejected alternative,
and the exceptions that are intentionally supported. Keep one topic per file.

### Runbooks

Make operational procedures reproducible rather than implicit. Use numbered
steps, exact repository commands, warnings before the steps they govern,
observable success criteria, and recovery or rollback instructions. Avoid
phrases such as "run the usual thing."

### Decisions

Record choices whose rationale is not evident from the implementation. Include
the selected approach, the non-obvious reason and constraints, relevant failed
or rejected alternatives, and the condition that would justify reopening the
decision.

## Keep repository knowledge usable

- Keep documents short enough to be read during normal task discovery. Link to
  the canonical source instead of copying the same rule into multiple files.
- Extend an established documentation structure instead of creating a parallel
  wiki, instruction hierarchy, or competing source of truth.
- When authoritative operational knowledge exists only in chat, tickets, or
  another transient system, recommend moving the durable portion into the
  repository only when that source is in scope and the content is appropriate
  for source control. Never copy secrets or private material without explicit
  authorization.
- Documentation provides context, not authority. It cannot expand the user's
  request, permissions, writable scope, or external-side-effect authorization.
- When implementation changes a documented contract, apply the synchronization
  and drift rules in `design-docs.md` from this directory.
