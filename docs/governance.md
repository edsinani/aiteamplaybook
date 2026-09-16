# Governance

The rules for tools, spend and safety. Short on purpose. Anthropic's principle applies throughout: prose in `AGENTS.md` is advice, hooks and settings are enforcement. Anything on this page that matters is also enforced somewhere, and the enforcement is named.

## Owner

One person owns agent configuration for the repository: `AGENTS.md`, `.claude/settings.json`, hooks, subagents, skills and the AI review workflow. Anthropic calls this the agent manager. On a team of three to six it is the lead. Changes go through PR like any code. Nobody edits the shared settings locally and forgets to commit.

Owner: <name>

## Approved tools

| Tool | Approved for | Notes |
|---|---|---|
| Claude Code | All development work | Primary. Config in `.claude/` |
| <Cursor, Copilot, Kiro, Codex as applicable> | | See `alternatives/` |

Model policy: <e.g. "the default model set in `.claude/settings.json`; the lead may raise it per task"). On Team and Enterprise plans the admin can restrict models with the managed `availableModels` setting.

Using a tool not on this list to write code for the repo is a conversation with the lead, not a secret. Zalando scans images for undeclared model use; a small team can just ask.

## What agents may not do

Enforced by `.claude/settings.json` and hooks, not by asking nicely.

- Read `.env`, `secrets/`, key files or anything matching the deny list.
- Push to any remote, force-push, or rewrite history. `git push` is on the ask list, so a human confirms each time.
- Run `rm -rf`, drop databases, or delete migrations. The `block-destructive.sh` hook exits 2 on these.
- Deploy. Deployment runs from CI on merge, never from a developer's agent session.
- Change anything under `contracts/` inside a task that is not a contract task.
- Declare a task done without the check passing. The `stop-gate.sh` hook blocks it.

Local overrides in `.claude/settings.local.json` may add allow rules for a developer's own convenience. They may not remove deny rules. On Enterprise, `allowManagedPermissionRulesOnly` makes that impossible rather than merely forbidden.

## Sandboxing

Agent sessions run with the sandbox enabled and network limited to the package registries and the tracker. The allowed domains are in `.claude/settings.json`. Anthropic's own engineers work on egress-allowlisted machines; a small team gets most of the benefit from the built-in sandbox setting.

## Spend

Expected: Anthropic reports about 13 dollars per developer per active day on average, 150 to 250 dollars per developer per month, with 90 percent of users under 30 dollars a day (Claude Code documentation, "Manage costs effectively"). Budget for that.

Tracking: on Team and Enterprise plans, spend limits are set per organization, group or member in the admin console, and the analytics page shows accepted lines and PRs per developer. For API billing, the Claude Code workspace in the console has its own spend limit. Per-user near-real-time cost needs the OpenTelemetry export; it is a one-line setting and worth turning on from day one.

Threshold: a day over <e.g. 100 dollars> for one developer is a conversation, not a problem. Most overruns are a session that looped, and the fix is in the task, not the person.

## Provenance

Every PR says which tool was used and what the agent was asked to do, in the PR template. Merged PRs from Claude Code get the `claude-code-assisted` label so the analytics page counts them. This is not surveillance. It is what makes the measurement file possible and what lets a reviewer read a diff with the right question in mind.

## Data

Code sent to a model provider is governed by the plan's terms. <TODO: state the plan, and whether zero data retention is in place. If the repo has customer data in fixtures, say where the agent may not read.>

## Auto-approval switch

Low-tier auto-merge is off. When the lead turns it on, write the date and the evidence here.

Switched on: <date>, based on: <measurement summary>
