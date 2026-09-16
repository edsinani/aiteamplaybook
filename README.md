# AI Team Playbook

Twelve rules for a team of three to six developers and one lead building software with AI coding agents, and the files that put them into practice. Copy this folder into a repository and the rules are installed: the instruction file, the shared permissions, the hooks, the spec templates, the review workflow and the policies.

The guide that explains every rule, with the evidence behind it, is at [intelligentrics.com/playbook](https://intelligentrics.com/playbook/). This repository is the kit that guide describes.

It is written for Claude Code first. Every practice has a note on how to do the same thing in Cursor, GitHub Copilot, Kiro or Codex, and the `alternatives/` folder has the file-by-file mapping.

## The twelve rules

Before code

1. **Write the constitution first.** The stack, the rules that never change, and the deliberate limits, on one page. `docs/constitution.md`
2. **One instruction file, under 200 lines.** Only what the agent cannot learn from the code. `AGENTS.md`
3. **Prose is advice, hooks are enforcement.** Anything that matters is blocked by a setting or a script, not asked for in a sentence. `.claude/settings.json`, `.claude/hooks/`
4. **Three gates before any code.** Requirements, design, tasks, each approved by the lead. `docs/specs/`
5. **A walkable demo before any screen.** A clickable prototype the lead has walked through, built by the developer or supplied by the product team, kept after shipping. `docs/prototypes/`

Building

6. **One task, one worktree, one pull request.** Under 400 changed lines, enforced by CI. `.github/workflows/ci.yml`
7. **Every contract has a file and two tests.** Where two components must agree, a test on each side catches a silent break. `docs/contracts.md`

Reviewing

8. **AI review first, and filtered.** An automated first pass on every pull request, told what not to report. `.github/workflows/ai-review.yml`
9. **Human review by risk tier.** Low, Standard or High on every task, and the tier decides who reviews. `docs/review-policy.md`
10. **Done means the evidence is in the pull request.** The check passed, and the pull request shows it. `docs/definition-of-done.md`

Over time

11. **Measure five numbers from day one.** A weekly baseline, started before anything else changes. `docs/measurement.md`
12. **Protect the people who are still learning.** Manual first, explain before merge, and a four-week rollout. `docs/onboarding-and-learning.md`

Each rule has one page on the site with the rule, who owns it, what enforces it, why, and how: [intelligentrics.com/playbook](https://intelligentrics.com/playbook/).

## What is in this repository

```
AGENTS.md                    the one instruction file, tool neutral
CLAUDE.md                    one import line plus Claude-only notes
docs/
  constitution.md            the stack and the rules that never change
  design.md                  system design template
  adr/                       architecture decision records, template and example
  specs/
    _template/               requirements.md, design.md, tasks.md for one feature
    example-document-title/  a worked example, all three files
  prototypes/README.md       the walkable demo rule
  contracts.md               machine-checked boundaries between services
  definition-of-done.md
  review-policy.md           risk tiers, the AI first pass, the 400 line limit
  governance.md              approved tools, spend, what agents may not touch
  measurement.md             the five numbers to record every week
  onboarding-and-learning.md protecting juniors, bringing people on
  roles-and-rituals.md       who owns what, and the weekly cadence
.claude/
  settings.json              shared permissions, hooks, sandbox
  hooks/                     block-destructive, lint-on-edit, stop-gate
  agents/                    reviewer, spec-checker, test-writer
  skills/                    /spec, /tasks, /review
.github/
  PULL_REQUEST_TEMPLATE.md
  workflows/ci.yml           pr-size, pr-template, gates, no-em-dashes
  workflows/ai-review.yml    AI first-pass review on every pull request
  copilot-instructions.md    points Copilot at AGENTS.md
alternatives/                the same setup in Cursor, Copilot, Kiro, Codex
extras/                      optional: CODEOWNERS and a guard job that lock the rule files
```

## Install

Ten steps, in order, each with a check. The full procedure with the exact commands is the [install checklist](https://intelligentrics.com/playbook/install/). In short:

1. Copy this folder's contents into the repository root, on a branch. Keep your own `README.md`. Add `.claude/worktrees/`, `.claude/settings.local.json` and `CLAUDE.local.md` to `.gitignore`.
2. Fill in `docs/constitution.md`. It is the only document the lead must finish before anyone else starts.
3. Fill in the `TODO` sections of `AGENTS.md`. Keep it under 200 lines.
4. Review `.claude/settings.json`. Adjust the allow list to the project's real commands. Do not remove a deny rule without a reason in `docs/governance.md`.
5. Make the hooks executable, `chmod +x .claude/hooks/*.sh`, and set the check command in `stop-gate.sh` to the project's real one.
6. Set up the AI review: `/install-github-app` from Claude Code, or install the GitHub app and add `ANTHROPIC_API_KEY` as an organization secret. Check the action's current documentation before the first run.
7. Protect the main branch: require the `gates`, `pr-size` and `pr-template` checks and one approving review. Create the `size/xl-override` label.
8. Write `docs/design.md` for the system as it exists today, replace the example ADR with your own first decision, and open the install pull request with the override label.
9. Run one small feature through the whole process with one developer, the lead reviewing each gate. Fix the templates where they were awkward.
10. Start `docs/measurement-log.csv` in the first week, before anything else changes.

## Working a task, step by step (Claude Code)

```
# from the repo root, on the main branch, up to date
claude --worktree task-142-review-queue-api
# inside the session: /spec if the feature has no requirements yet, /tasks to split it,
# then build the one task, run the check, /review, open the PR with the template
```

The worktree lands in `.claude/worktrees/task-142-review-queue-api/` on its own branch. Permissions granted in a worktree are saved to the main checkout, so nobody re-approves the same command per task. When the PR is merged, delete the worktree.

For other tools see `alternatives/`.

## What this does not do

Nothing here stops a developer from editing a hook. The files live in the repository, and anyone who can edit code can edit them. What stops a broken rule from landing is the pull request: an automated reviewer reads it and a human reviewer has a say before it merges. A team that wants the rule files themselves locked follows `extras/README.md`.

## Sources

Every number in the playbook is cited on the site, with a link to the study or the engineering post it comes from: [intelligentrics.com/playbook/tools](https://intelligentrics.com/playbook/tools/).
