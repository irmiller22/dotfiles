# General engineering standards

These language-independent standards apply across repositories. More specific
project or language guidance may narrow them.

## Correctness

- Working code is the primary requirement.
- Do not leave the repository in a broken state.
- Run the repository's existing build, type-check, lint, and test commands when
  applicable.
- Fix failures caused by the implementation before declaring work complete.

## Type safety

Type safety is mandatory in every language that supports it. This is not a
stylistic preference — it is a correctness requirement on the same footing as
passing tests.

- Enable the language's static type checker and run it in CI as a required
  gate, not an advisory step. A green test run is never a substitute for a
  green type check; run both.
- Configure the checker toward its strictest practical setting. Do not disable
  strictness flags to make code pass.
- Annotate everything the language cannot infer: function signatures, public
  APIs, and any value crossing a module or service boundary.
- Do not defeat the type system. Avoid escape hatches (`any`, unchecked casts,
  `# type: ignore`, non-null assertions, `@ts-ignore`) unless correctness is
  genuinely guaranteed and the reason is documented inline. Prefer modeling the
  real shape of the data over silencing the checker.
- Type errors are build failures. Do not declare work complete while the type
  checker reports errors introduced by the change.

Language-specific type-checker configuration lives in the relevant language
guideline (e.g. `python.md`, `typescript-nextjs.md`); this section states the
non-negotiable baseline they inherit.

## Simplicity

Prefer straightforward code over clever code. Prefer the smallest clear
implementation that satisfies the requirements.

Avoid:

- Premature abstractions or optimization.
- Unnecessary architectural layers.
- Wrapper functions or components with no meaningful behavior.
- Utilities created for a single trivial operation.
- Design patterns introduced only for their own sake.

## Scope control

Implement the requested feature completely before adding enhancements. Make
the smallest coherent change that satisfies the task.

Do not:

- Rewrite unrelated working code.
- Reformat unrelated files.
- Rename unrelated components.
- Change architecture unnecessarily.
- Add speculative functionality.

## Dependencies

Minimize new dependencies. Before adding one, determine:

1. Can the language, platform, or framework already solve the problem?
2. Does an existing dependency already provide the functionality?
3. Does the dependency materially simplify the implementation?

Do not add dependencies for trivial functionality.

## Naming

Use descriptive, domain-specific names. Avoid vague names such as `data`,
`thing`, `manager`, `service`, or `handler` when a more precise name is
practical.

## Comments

Comments should primarily explain why something is necessary. Do not add
comments that merely restate obvious code.

## Existing code

Before modifying a repository:

1. Inspect the repository structure.
2. Inspect dependency and build configuration.
3. Identify existing conventions.
4. Identify reusable components and utilities.
5. Preserve established patterns when practical.

Do not rewrite working code merely to enforce a preferred architecture.

## Verification

Before declaring work complete:

1. Re-read the requirements.
2. Review the final diff.
3. Remove temporary debugging code.
4. Remove dead code.
5. Confirm no unnecessary dependencies were added.
6. Run applicable build, type-check, lint, and test commands.
7. Fix failures caused by the implementation.
