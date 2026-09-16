# GitHub Copilot

`AGENTS.md` at the root is read by the cloud agent, code review and chat. `.github/copilot-instructions.md` in this playbook only points at it. Priority is personal instructions, then repository, then organization.

## Instruction files

Path-scoped rules go in `.github/instructions/<name>.instructions.md`:

```
---
applyTo: "worker/**"
excludeAgent: "code-review"
---
Run `pytest -q` from `worker/` before declaring a task done.
```

`excludeAgent` keeps a rule out of code review or out of the cloud agent when it only makes sense for one of them.

## Permissions

The cloud agent runs in an ephemeral GitHub Actions environment, opens draft PRs only, and has a session cap under an hour. That environment is the sandbox. Configure what it can install and run in `.github/workflows/copilot-setup-steps.yml`. Secrets are Actions secrets, scoped the usual way; the agent cannot read repository secrets it is not given.

For local Copilot in the editor there is no committed allow, ask, deny file. Enforcement is hooks and branch protection.

## Hooks

`.github/hooks/<name>.json` for the repository, `~/.copilot/hooks/` for the CLI:

```json
{
  "version": 1,
  "hooks": {
    "preToolUse": [
      { "type": "command", "bash": ".claude/hooks/block-destructive.sh" }
    ],
    "postToolUse": [
      { "type": "command", "bash": ".claude/hooks/lint-on-edit.sh" }
    ],
    "agentStop": [
      { "type": "command", "bash": ".claude/hooks/stop-gate.sh" }
    ]
  }
}
```

`preToolUse` can deny. Check the stdin field names against the current docs and adjust the extraction lines in the scripts.

## Custom agents

`.github/agents/reviewer.agent.md` with frontmatter `name`, `description`, `tools`, `model`, `target`, optional `mcp-servers`, and the same body as `.claude/agents/reviewer.md`. Organization-wide agents live in the org's `.github` or `.github-private` repository and are selectable when assigning an issue to Copilot.

## Team commands and the spec workflow

The cloud agent has a built-in research, plan and code flow: it drafts an implementation plan the developer approves before code is written. That is the design gate, not a replacement for `requirements.md`. Keep `docs/specs/` and have the developer paste the task entry (with its Satisfies, Touches and Verification lines) into the issue body before assigning it to Copilot. GitHub Spec Kit's `/speckit.taskstoissues` does this from `tasks.md`.

## Parallel work

Assign one issue per task to Copilot. Each runs in its own Actions job and opens its own draft PR. Local worktrees by hand for human-driven tasks.

## AI review

Copilot code review reads `AGENTS.md` (root) and `.github/instructions/`. Put the review rules from `docs/review-policy.md` section 2 in an instructions file with `applyTo: "**"` and no `excludeAgent`. Delete `.github/workflows/ai-review.yml` if Copilot is the reviewer. Branch protection can require the Copilot review before merge.

## Provenance

PRs opened by the cloud agent are attributed to Copilot. For human-driven work with local Copilot, the PR template's "How it was built" section is the record.
