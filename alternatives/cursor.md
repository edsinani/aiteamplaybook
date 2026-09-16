# Cursor

`AGENTS.md` at the root is read natively. Delete `CLAUDE.md` and `.claude/` if the team is Cursor-only, or keep them for mixed teams; Cursor also reads `.claude/agents/` for subagents.

## Instruction file

Cursor reads `AGENTS.md` (root and nested). For rules that should only apply to some paths, add `.cursor/rules/<name>.mdc`:

```
---
description: Rules for the worker service
globs: ["worker/**"]
alwaysApply: false
---
Run `pytest -q` from `worker/` before declaring a task done.
Regenerate `contracts/extraction-field-manifest.json` after any flattener change.
```

Precedence is Team Rules (dashboard, Team and Enterprise plans), then project rules, then user rules. Keep every rules file under 500 lines. Put the constitution's non-negotiables in a Team Rule so a developer's local rules cannot override them.

## Permissions and hooks

Cursor has no committed allow, ask, deny file equivalent to `.claude/settings.json`. Enforcement is hooks. `.cursor/hooks.json` at the repo root:

```json
{
  "version": 1,
  "hooks": {
    "beforeShellExecution": [
      { "command": ".claude/hooks/block-destructive.sh" }
    ],
    "afterFileEdit": [
      { "command": ".claude/hooks/lint-on-edit.sh" }
    ],
    "stop": [
      { "command": ".claude/hooks/stop-gate.sh" }
    ]
  }
}
```

The hook scripts read JSON on stdin in both tools, but the field names differ. Cursor passes `command` for shell hooks and `file_path` for edit hooks at the top level; adjust the `python3 -c` extraction lines in each script, or keep two copies under `.cursor/hooks/`. A `deny` from any hook beats `ask` beats `allow`. Enterprise teams can distribute hooks from the cloud so a repo cannot omit them.

## Subagents

`.cursor/agents/reviewer.md` with the same body as `.claude/agents/reviewer.md`. Frontmatter fields are `name`, `description`, `model`, `readonly: true`, `is_background`. Cursor also reads `.claude/agents/` directly, so a mixed team keeps one copy.

## Team commands

The `/spec`, `/tasks` and `/review` skills become rules with `alwaysApply: false` that the developer invokes by name in chat ("apply the spec rule"), or a short prompt file the team shares. Cursor's Cloud Agents (formerly Background Agents) can run a task from an issue in Linear, Slack or GitHub in an isolated VM; environment in `.cursor/environment.json`.

## Parallel work

Cloud Agents each get their own VM and branch. For local parallel work use `git worktree add` by hand and open each worktree in its own Cursor window.

## AI review

Bugbot reviews PRs on GitHub, GitLab, Bitbucket and Azure DevOps. Tune it in `.cursor/BUGBOT.md`; note that `.cursor/rules` do not apply to Bugbot, so copy the review rules from `docs/review-policy.md` section 2 into that file. Autofix spawns a Cloud Agent for a finding. Delete `.github/workflows/ai-review.yml` if Bugbot is the reviewer.

## Spec workflow

Same `docs/specs/` folder. Or `specify init --integration cursor` to get Spec Kit's commands inside Cursor.
