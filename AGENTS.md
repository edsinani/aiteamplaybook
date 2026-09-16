# Instructions for coding agents

This is the one instruction file. Claude Code reads it through `CLAUDE.md`, Copilot through `.github/copilot-instructions.md`, Cursor, Codex and Kiro natively. Keep it under 200 lines. Put in only what an agent cannot learn from the code: commands, conventions that differ from defaults, repo etiquette, and pointers. If a rule needs enforcing, it is a hook, not a line here.

## Read first

- `docs/constitution.md`: the stack and the non-negotiables. Do not propose changes to them; raise them.
- `docs/design.md`: how the system is built and why. Section 7 lists things that look wrong on purpose.
- The task's spec folder under `docs/specs/<feature>/`: requirements, design, tasks. Cite requirement numbers in tests and PRs.

## Commands

<!-- TODO: the commands the agent cannot guess. Examples from a three-service repo: -->

```
# API (.NET)
dotnet build
dotnet test                          # unit + integration
dotnet test --filter Category=Unit

# Worker service (Python)
cd worker && pytest
cd worker && python scripts/generate_field_manifest.py   # regenerate contracts/ after any flattener change

# Frontend
cd frontend && npm run type-check && npm run test && npm run build

# Local stack
docker compose up -d                 # database, storage emulator, queue
```

## Repo etiquette

- Branch: `task/<tracker-id>-<slug>`. One task per branch, one branch per PR.
- Commits: Conventional Commits. Subject under 72 characters. Keep bodies short.
- PR: use the template. Fill in every line. The verification evidence is not optional.
- Under 400 changed lines per PR. If the task will not fit, stop and propose the split.
- Never commit, push, deploy or run destructive commands. Give the exact git commands for the developer to run.

## How to work

- Read the task's `Touches` and `Do not touch` lines before editing. Stay inside them. If the task needs a file outside them, stop and say so.
- Look for a pattern that already exists before inventing one. Keep code consistent with its neighbours.
- Strategic questions (architecture, scope, approach) are raised in prose, before code. Tactical decisions are made, not asked.
- Before changing anything under `contracts/`, any DTO, queue message or field name another service reads: stop and say so. Contract changes are their own task.
- If you catch yourself adding a rule, mechanism or fix named after a specific failing test case, stop. Surface the pattern before writing the code.
- If the same component needs a second redesign to keep working, stop. Surface it.
- Comments only where the reason is not obvious from the code. No narration.
- Hyphens, never em dashes, in code, comments and docs.

## Definition of done

Before saying a task is complete: run the check, show the output, and confirm the change answers the task's verification line, not just that the code runs. Full list in `docs/definition-of-done.md`. A hook will run the check anyway.

## Where things are

<!-- TODO: five to ten lines. Not a file tour. The places a new developer asks about in the first week. -->

- Shared UI components: `frontend/src/components/`
- Business rules: `src/<Project>.Rules/`
- Contracts and their guard tests: `contracts/README.md`
- Prototypes: `docs/prototypes/`

## Code review rules

<!-- Codex reads this section for its review. Keep it aligned with docs/review-policy.md. -->

- Flag anything named after a test case or fixture value.
- Flag contract changes without both guard tests changed.
- Flag missing tests for a cited requirement.
- Do not comment on style the linter covers.
