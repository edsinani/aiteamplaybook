# OpenAI Codex

`AGENTS.md` is Codex's native instruction file; the standard started there. Codex reads `~/.codex/AGENTS.md`, then every `AGENTS.md` from the git root down to the working directory, concatenated root-down, capped at 32 KiB by default (`project_doc_max_bytes` in `~/.codex/config.toml`). Nested files apply to their subtree.

## Instruction files

The root `AGENTS.md` is used as is. For per-service rules add `worker/AGENTS.md` and `frontend/AGENTS.md` with only what differs.

## Permissions

Sandbox and approval policy are per-user in `~/.codex/config.toml`, not committed. Set the team's expected values in `docs/governance.md` and check them in onboarding: workspace-write sandbox, network off unless a task needs it, approval on anything outside the workspace. There is no committed deny list, so `block-destructive.sh` has no hook to run from; branch protection and the CI gates are the enforcement.

## Hooks

Not documented as of September 2026. Treat `stop-gate.sh` as a manual step: the developer runs the project check before `/review`.

## Subagents

`.codex/agents/<name>.toml` in the repo, or `~/.codex/agents/`. Required fields `name`, `description`, `developer_instructions`. Built-ins are `default`, `worker`, `explorer`. Port `reviewer.md` by putting its body in `developer_instructions`.

## Team commands

Sections in `AGENTS.md`. The `/spec`, `/tasks` and `/review` procedures can be pasted as headed sections the developer asks for by name.

## Parallel work

Local worktrees by hand, one Codex session each.

## AI review

Codex reviews via the GitHub app and `@codex review` on a PR. Review rules live in a `## Code Review Rules` section of `AGENTS.md`; the playbook's `AGENTS.md` already has one. Delete `.github/workflows/ai-review.yml` if Codex is the reviewer.

## Spec workflow

GitHub Spec Kit supports Codex (`specify init --integration codex`). Or keep `docs/specs/` and drive it from the `AGENTS.md` sections.
