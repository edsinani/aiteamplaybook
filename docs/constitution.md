# Constitution

The rules that hold for the whole project. Every agent session reads this file through `AGENTS.md`. Every design, requirement and task is checked against it. Change it by pull request with the lead's approval, and record why in an ADR.

Keep it short. If a rule needs a paragraph, it is a design decision and belongs in an ADR.

## Purpose

<!-- TODO: one paragraph. What the system is for and who uses it. -->

## Stack

| Layer | Choice | Version pin | Rationale |
|---|---|---|---|
| Backend | <!-- e.g. ASP.NET Core --> | <!-- e.g. .NET 10, pinned in global.json --> | |
| Data | <!-- e.g. SQL Server, EF Core with migrations --> | | |
| Frontend | <!-- e.g. Vue 3, Pinia, Tailwind --> | | |
| Services | <!-- e.g. Python 3.12, FastAPI --> | | |
| Infra | <!-- e.g. Azure Container Apps, Bicep --> | | |
| CI | <!-- e.g. GitHub Actions --> | | |

Worked example of a row from a document-processing product: "Extraction engine: hosted document-intelligence API for the MVP, custom models later. Rationale: high accuracy on day one with no training data; corrections collected in production feed the custom models. This is a bridge, not a destination." That is the kind of sentence that saves an agent from proposing a rewrite.

## Non-negotiables

Rules the agent must never break and the reviewer must always check.

1. No secrets in the repository. `.env` files are local and listed in `.gitignore`. Configuration is read from environment variables with a documented `.env.example`.
2. Every change to a service boundary updates the contract and the tests on both sides. See `docs/contracts.md`.
3. Every schema change ships as a migration in the same PR.
4. Tests run in CI on every PR. A red check blocks merge.
5. One task per branch, one branch per PR, under 400 changed lines unless labelled `size/xl-override` with a reason.
6. The agent does not push, deploy or run destructive commands. Hooks enforce this.
7. User-facing work has an approved walkable demo before code. See `docs/prototypes/README.md`.

## Conventions

Branch names: `task/<tracker-id>-<short-slug>`.

Commit messages: Conventional Commits (`feat:`, `fix:`, `chore:`, `docs:`, `test:`, `refactor:`), subject under 72 characters, body optional. Agent-written bodies are trimmed to 20 lines by the pre-commit hook.

Language: American English in code and docs. Hyphens, never em dashes.

<!-- TODO: add the three to five conventions that differ from the language defaults. Leave out anything a linter already enforces. -->

## Deliberate limits

Things the system does not do, so the agent does not helpfully add them.

<!-- Example: "English-language documents only. Non-English documents are flagged, not processed. Decided in ADR-0003." -->

## Quality bar

The definition of done is in `docs/definition-of-done.md`. The short form: the change answers the question the task asked, the evidence is in the PR, and a stranger can run it from the README.
