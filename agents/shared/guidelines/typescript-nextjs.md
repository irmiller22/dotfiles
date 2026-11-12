# TypeScript, React, and Next.js standards

Read this file before changing or reviewing TypeScript, React, browser, or
Next.js code. Generic engineering guidance belongs in
`general-engineering.md` from this directory.

## TypeScript

Use strict TypeScript.

- Do not use `any`.
- Prefer `unknown` for genuinely unknown values.
- Define types for API request parameters and responses.
- Type React component props explicitly.
- Prefer inference for obvious local variables.
- Avoid unnecessary `as` assertions.
- Avoid non-null assertions unless correctness is guaranteed.
- Handle `null` and `undefined` explicitly.
- Prefer discriminated unions for state with multiple variants.
- Avoid unnecessary duplicate types.
- Prefer domain-specific types over generic objects when the structure is
  known.

## React

Use functional React components.

- Keep components focused and prefer composition.
- Extract components when doing so improves readability or reuse, not only to
  reduce line count.
- Keep state close to where it is consumed.
- Avoid duplicated or redundant state.
- Derive values during rendering when practical.
- Follow the Rules of Hooks.
- Do not use `useEffect` for values that can be derived during render.
- Do not use `useMemo` or `useCallback` without a concrete reason.
- Avoid premature performance optimization.

## Next.js

Follow the architecture already established by the repository. If it uses the
App Router, continue using it unless the task requires otherwise.

### Server and Client Components

Prefer Server Components by default. Use `"use client"` only when client-side
functionality requires it, such as:

- `useState`.
- `useEffect`.
- Browser APIs.
- Event-driven interactive state.

Keep Client Component boundaries as small as practical. Do not convert an
entire page to a Client Component when only one interactive section requires
client-side behavior.

## Data fetching

- Keep HTTP concerns separate from presentation logic when practical.
- Prefer small typed API functions over substantial request logic embedded
  directly inside UI components.
- Use `URLSearchParams` when constructing query parameters.
- Check `response.ok` before consuming HTTP response data.
- Do not assume requests always succeed.
- Defensively handle API response data when its shape cannot be trusted.
- Do not introduce a schema-validation dependency for a trivial API unless the
  repository already uses one or the complexity justifies it.

## Interactive search

- Trim input where appropriate.
- Avoid requests for clearly invalid input.
- Debounce API calls when requests occur on every keystroke.
- Prevent stale responses from replacing newer results.
- Prefer `AbortController` when request cancellation is appropriate.
- Do not introduce a data-fetching library only for basic search behavior.

An older request must never overwrite the results of a newer request.

## Pagination

When an API uses `limit` and `offset`:

- Keep pagination state minimal.
- Derive `offset` where practical.
- Reset pagination when the search query changes.
- Disable invalid navigation actions.

Prefer deriving:

```ts
const offset = page * limit;
```

rather than storing both `page` and `offset` independently.

## Async UI

Asynchronous user interfaces should account for relevant states:

- Initial.
- Loading.
- Success.
- Empty.
- Error.

Do not display an empty-results state while a request is loading. Do not leave
the interface blank during loading. Provide retry behavior when useful.

## Accessibility

Accessibility is part of correctness. Use semantic HTML.

- Use `<button>` for actions.
- Use `<a>` or Next.js `<Link>` for navigation.
- Associate form controls with labels.
- Avoid clickable `<div>` elements when a semantic element exists.
- Ensure interactive functionality works with a keyboard.
- Preserve visible focus indicators.
- Give icon-only buttons accessible labels.
- Mark decorative icons appropriately.

## Styling

Follow the styling system established by the repository. When Tailwind CSS is
present:

- Prefer Tailwind over unnecessary custom CSS.
- Follow existing design conventions.
- Keep layouts responsive.
- Avoid excessive arbitrary values.
- Avoid unnecessary animation.
- Support narrow viewports.

## Browser APIs

Prefer standard browser APIs such as `fetch`, `URLSearchParams`, and
`AbortController` when they solve the problem cleanly. Do not add dependencies
for functionality already provided clearly by the browser or framework.
