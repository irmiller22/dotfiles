# Python — best practices

Apply these to every Python project unless the project's own `AGENTS.md`,
`CLAUDE.md`, or design document explicitly overrides them.

## Testing

- **Cover happy and sad paths.** Every unit test file should exercise both the success case and the failure modes that matter (invalid input, permission denied, not found, conflict, state-machine violation). A test suite that only proves the happy path passes is not finished.
- **Every feature / endpoint / service method gets tests.** New API endpoints are not done until they have request-level tests covering: 2xx happy path, 4xx for client errors (validation, auth, ownership), and any business-rule failures. New service methods need unit tests covering their explicit branches.
- **E2E integration tests for core feature flows.** For any user-facing flow that spans modules (e.g. "sign up → request walk → assign → complete → invoice → pay"), write at least one end-to-end integration test that drives the full flow through the API surface. These belong in `tests/integration/` and are separate from per-module unit tests.
- Test names describe capabilities in plain English (`test_client_can_request_walk_for_their_own_dogs`), not HTTP verbs (`test_post_appointment`).
- Run tests before declaring a task done. Type checking is not a substitute.

## Architecture — DAO / DTO pattern

When code interacts with a database, keep three layers separate:

1. **ORM models (`models.py`)** — SQLAlchemy declarative tables. No business logic, no HTTP knowledge.
2. **DAO / repository (`dao.py` or `repository.py`)** — The only layer that issues SQLAlchemy queries. Methods take primitive args or DTOs and return DTOs (or domain objects), never raw ORM rows leaking out of this layer. Keeps the service layer testable without a real DB and makes query patterns auditable in one place.
3. **DTOs (`schemas.py`)** — Pydantic models for everything crossing a boundary: API request/response, DAO returns, inter-module calls. Never pass ORM instances across module boundaries.

Service layer (`service.py`) holds business rules, calls into the DAO, and returns DTOs. It must not import SQLAlchemy directly. Routers (`router.py`) are thin: parse request → call service → return DTO.

Benefits: services are testable with a fake DAO; query changes happen in one file; API contracts are explicit; ORM rows can't accidentally serialize into responses.

## General

- Prefer Pydantic v2 features (`model_validate`, `model_dump`) over v1 idioms.
- Type-annotate everything; `from __future__ import annotations` at the top of each module so forward refs work.
- Service-layer exceptions are domain types (`NotFoundError`, `PermissionDeniedError`, `ConflictError`), mapped to HTTP at the router or via a global exception handler.
- Return `404` for resources the caller is not permitted to see (do not leak existence with `403`).

## Linting & formatting (ruff)

Ruff is the linter and formatter. Run it at **project scope**, never on individual
files: `ruff check --fix .` then `ruff format .`. Surface both via a `make fmt`
(fix + format) and `make lint` (check only) target, and run `lint` in CI as a
required gate.

Baseline config (`pyproject.toml`):

```toml
[tool.ruff]
line-length = 100
target-version = "py312"   # pin to the project's minimum

[tool.ruff.lint]
select = [
  "E", "F", "I", "B", "UP",          # pycodestyle, pyflakes, isort, bugbear, pyupgrade
  "SIM", "C4", "RET", "PIE", "RUF",  # simplify, comprehensions, returns, misc, ruff-native
  "FURB", "PERF", "RSE",             # refurb (modernize), perflint, raise
  "TC",                              # flake8-type-checking (move annotation-only imports)
  "DTZ",                             # flake8-datetimez — forbid naive datetime
]
ignore = [
  "B008",  # function-call-in-default-argument — Depends(...) is idiomatic FastAPI
]
```

- **Do not enable `PLR2004` (magic-value-comparison) project-wide** — it's
  overwhelmingly noise (test assertions, `precision=10`, `days=30`, etc.).
  Promote genuinely meaningful literals to named constants by judgement, not by
  lint rule.
- **Do not enable `D` (pydocstyle) or `ANN` (annotations) blanket** — high churn,
  low value. Type annotations are enforced by the type checker instead (below).
- `DTZ` is high-value: it forbids `datetime.now()`/`utcnow()` without a tz.
  Always use `datetime.now(tz=UTC)`; reject naive datetimes at API boundaries
  (Pydantic `AwareDatetime`). In tests that deliberately construct naive values,
  scope a `# noqa: DTZ005`.

## Type checking

Type checking is **required, not optional** — "type-annotate everything" is only
meaningful if a checker enforces it. Run a static type checker in CI as a gate:

- Prefer `mypy` (or `pyright`/`ty`) configured toward strict. At minimum enable
  `disallow_untyped_defs`, `warn_unused_ignores`, `warn_redundant_casts`.
- A green test run is **not** a substitute for type checking; run both.
- Keep `from __future__ import annotations` at the top of every module so
  annotations are lazily evaluated and forward refs work.

## FastAPI & SQLAlchemy idioms

Settled conventions — do not re-flag these in audits/reviews:

- **PATCH updates**: `payload.model_dump(exclude_unset=True)` + a `setattr` loop
  is the correct idiom for applying partial updates to an ORM row. Do not expand
  it into per-field assignments.
- **Dependency factories**: a small named factory
  (`def _svc(db: Session = Depends(get_db)) -> FooService`) is idiomatic FastAPI.
  Do not replace with lambdas in `Depends(...)`.
- Use **PEP 695 generics** (`def f[T](...) -> T`) when `requires-python >= 3.12`;
  no `TypeVar` boilerplate needed.

Active rules:

- **Eager-load, don't poke.** When a relationship is needed for response
  serialization, use `select(...).options(selectinload(Model.rel))`. Never rely
  on `_ = obj.rel` lazy-load side effects — they're cryptic, silently break on
  rename, and cause N+1 on list endpoints.
- **No function-local imports to break cycles.** Constructor-inject the
  collaborating service (`other: OtherService | None = None` → default-construct
  in `__init__`). Explicit dependency, fake-able in tests.
- Services hold their session as `self._db` (leading underscore, consistent
  across modules).

## Duplication & shared helpers

- **Rule of three.** Once the same pattern (ownership check, scoped lookup,
  role→query-filter ladder) is inlined in ~3 places across modules, extract a
  shared helper and migrate the call sites.
- **A shared helper must be adopted or deleted.** A "convention" helper that
  exists (and is tested) but that no production code calls is worse than none —
  it documents a convention nobody follows. When you find one: either migrate
  call sites onto it in the same PR, or remove it.

## Idiomatic Python

- **Money is `Decimal`, never `float`.** Do integer/Decimal arithmetic, multiply
  before dividing to stay exact, and `.quantize(Decimal("0.01"),
  rounding=ROUND_HALF_UP)` — not the default banker's rounding — for currency.
- **Datetimes are timezone-aware (UTC) end to end.** Compare only aware to aware.
- Prefer comprehensions / generator expressions over `map`/`filter` + `lambda`
  when it reads more clearly; prefer `pathlib` over `os.path`.
- Prefer `{}`/`[]`/`set()` literals over `dict()`/`list()` calls (`C408`).
- Don't unpack values you don't use (`a, _ = ...`), and delete unused `# noqa`.
