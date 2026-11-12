# Design documents — keeping them honest

Applies to any project with an authoritative design/spec document (Linear doc,
ADR, RFC). A design doc that has drifted from the implementation is worse than
no doc — readers (human or agent) build on its claims.

## Sync discipline

- **Contract changes update the doc in the same ticket.** If a PR changes an
  API endpoint (path, access, shape), a data-model field/enum, or a state
  machine (new transition, new role), updating the design doc is part of that
  ticket's definition of done — not a someday cleanup.
- **Document derived vs stored.** If a status is computed at read time (e.g.
  `overdue` derived from `due_at`, `expired` derived from `expires_at`) rather
  than persisted, the doc must say so. Listing a derived value as a stored enum
  member misleads implementers.
- **No phantom promises.** Don't let the doc claim infrastructure that doesn't
  exist (rate limiting, audit logging, URL versioning prefixes). Either ticket
  the gap or mark the item explicitly as post-MVP / not yet implemented.

## Internal consistency checks

When reviewing or writing a design doc, cross-check:

- **Units and rates agree across sections.** A billing model where one table
  charges hourly and another pays per-walk, with no stated conversion, is a
  spec bug — it will surface later as an implementation blocker.
- **Prose matches tables.** A summary line ("cancellable from any non-terminal
  state") must agree with the enumerated transition table; when they conflict,
  the ambiguity becomes a real bug.
- **Permission matrix matches the endpoint list.** Every matrix row should map
  to an endpoint (or be explicitly system-triggered); every endpoint's access
  column should match the matrix.

## Periodic drift audit

On request or at milestone boundaries, diff the doc against the code:
endpoints (method/path/access), model fields and enum members, state-machine
transitions, config variables, and security requirements. Report drift in three
buckets: doc-only fixes, code-or-doc decisions, and doc-promises-code-lacks
(ticket candidates).
