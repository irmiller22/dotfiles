# Technical interview standards

These standards are programming-language and framework independent. Read them
when working on a technical interview exercise.

## Objective

Optimize for:

1. Correctness.
2. Simplicity.
3. Readability.
4. Explainability.
5. Appropriate type safety when supported by the language.
6. Accessibility when a UI is involved.
7. Good user experience.

Do not optimize for hypothetical production-scale requirements unless
explicitly required. Prefer the smallest clear implementation that completely
solves the problem.

## Explainability

Assume every implementation decision may need to be explained to an
interviewer. Prefer decisions with concise technical justification. Avoid
architecture that requires substantial explanation without providing clear
value.

## Avoid over-engineering

Avoid:

- Repository patterns for one API call.
- Service classes around simple functions.
- Dependency injection without a concrete need.
- Global state for local state.
- Trivial custom hooks or equivalent abstractions.
- Generic wrappers with no meaningful behavior.
- Premature abstractions or optimization.

Do not create abstractions for hypothetical future requirements. A reviewer
should be able to understand the primary application flow quickly.

## Scope

Solve the requested problem completely before adding enhancements. Avoid
speculative features such as:

- Authentication.
- Persistent storage.
- Analytics.
- Internationalization.
- Global state management.
- Complex caching.
- Elaborate design systems.
- Infrastructure not required by the exercise.

Small improvements are acceptable when they directly improve correctness,
accessibility, reliability, usability, or code clarity.

## Interview dependencies

Treat every new dependency as a design decision. Before adding one, ask:

1. Is it necessary to satisfy the exercise?
2. Can the standard library or framework solve the problem?
3. Does it materially reduce complexity?
4. Can its inclusion be easily defended during the interview?

Avoid dependencies that save only a few lines of straightforward code.

## Work process

Before implementing:

1. Read the requirements completely.
2. Inspect the existing repository.
3. Inspect relevant configuration and dependencies.
4. Identify constraints.
5. Identify the smallest implementation that satisfies the requirements.

Then implement. Do not begin with broad refactoring.

## User experience

When relevant, account for:

- Loading.
- Empty results.
- Errors.
- Invalid input.
- Repeated interactions.
- Keyboard use.
- Narrow screens.

Do not implement elaborate visual polish before basic behavior is correct.

## Testing

Use the project's existing verification tools. Do not introduce a new testing
framework only to demonstrate testing knowledge unless testing is explicitly
required.

Where practical, reason through:

- Normal behavior.
- Empty results.
- Error behavior.
- Boundary values.
- Repeated actions.
- Race conditions.

## Requirements

Explicit interview requirements are the source of truth. Do not reinterpret
required frameworks, languages, APIs, build commands, protocols, or user
behaviors. Optional improvements must not put explicit requirements at risk.

## Completion

Before declaring the exercise complete:

1. Re-read the original requirements.
2. Compare every requirement with the implementation.
3. Review the final diff.
4. Remove temporary code and logs.
5. Remove dead code.
6. Confirm unnecessary dependencies were not added.
7. Run the required build and verification commands.
8. Fix failures caused by the implementation.

Do not state that the task is complete if a required build fails.

## Final report

- Be concise.
- State what changed.
- State important design decisions.
- State which verification commands were run.
- Report failures honestly.
- Mention meaningful tradeoffs when relevant.

Do not provide a long tutorial unless requested.
