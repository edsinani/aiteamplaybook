# Instructions for GitHub Copilot

The team's instructions live in `AGENTS.md` at the repository root. Copilot's coding agent, code review and chat all read `AGENTS.md` natively; this file exists so that any Copilot surface that looks here first finds the pointer.

Follow `AGENTS.md`. Then `docs/constitution.md`. Then the task's spec under `docs/specs/`.

Path-scoped rules, if the team needs them, go in `.github/instructions/<name>.instructions.md` with an `applyTo` glob. See `alternatives/copilot.md`.
