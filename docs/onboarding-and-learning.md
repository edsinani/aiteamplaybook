# Onboarding and learning

Two problems with one cause. A new developer has to learn the codebase, and a junior developer has to learn the craft. Agents make both harder because they remove the struggle that learning comes from. In a randomized trial of 52 mostly junior engineers learning an unfamiliar library, the group using AI scored 50 percent on comprehension against 67 percent without it, with the largest gap in debugging (Anthropic, February 2026). The long-term version of this now has a name, comprehension debt (Addy Osmani, "Comprehension Debt: The Hidden Cost of AI-Generated Code", O'Reilly Radar, April 2026).

This document is for teams that need it. A team of experienced developers who have all shipped without agents can skip to the onboarding section.

## Onboarding a developer to the repo

Day one, in this order, before any agent session.

1. Read `docs/constitution.md`, `docs/design.md` and one Implemented feature spec end to end.
2. Run the system locally from the README. If a step fails, fixing the README is the first PR.
3. Read `AGENTS.md`. It is what the agent knows; the developer should know at least that much.
4. Walk one merged PR from a Standard-tier task with its reviewer: the task entry, the spec it cites, the diff, the AI findings, the human comments. This is where the review policy becomes real.

Day two, the first task: a Low-tier task from the current milestone, done with an agent, with the lead as reviewer. The goal is not the task. It is the first walk through worktree, hook, PR template, AI review and human review.

First week: one spec written (requirements, design, tasks) for a small feature, approved by the lead. Writing the spec is how a developer learns the system faster than reading it.

## Protecting learning

Rules for juniors and for anyone new to the stack. The lead decides who they apply to and for how long. Written here so they are policy and not a personal comment.

Manual first. For the first <two> weeks in a new area of the codebase, the developer implements one task in that area without an agent, then reviews an agent's implementation of the next one against their own. Comparison is the fastest teacher.

Explain before merge. On Standard and High tasks, the author must be able to explain every line of the diff to the reviewer without the agent. If they cannot, the PR waits. Of these rules it is the one we would keep if we could keep only one, and it costs nothing when the author already understands the change.

Debug by hand first. When a test fails, the developer forms a hypothesis and checks it before asking the agent. Fifteen minutes, then the agent. Debugging is where the study found the largest gap.

Read the agent's plan, not just its diff. Ask the agent to say what it will do before it does it. Disagreeing with the plan is where judgment forms.

One review a week without the AI first pass. Each developer reviews one PR a week before reading the AI findings, then compares. This keeps human review skill alive and calibrates trust in the reviewer.

## Bringing a team on

For a team adopting the playbook together, in order.

Week 1: the lead backfills the measurement baseline, installs the playbook and runs one feature through it alone. Fix the templates.

Week 2: one developer joins, on a Low-tier task, then a Standard one. The lead reviews every step. Fix the templates again.

Week 3 and 4: the rest of the team, one feature each, all through the full flow. The weekly checkpoint starts. The measurement file has the backfilled baseline and three weeks under the playbook to compare it with.

Milestone 2: review the measurement numbers. Decide on Low-tier auto-approval. Retire any rule nobody has needed.

Adoption spreads by watching, not by mandate. A study of Microsoft's early-2026 rollout across tens of thousands of engineers found that whether the people around you had already tried an agent predicted adoption better than any mandate or training (arXiv 2607.01418, July 2026). Pair on the first task. Show the worktree and the hook firing. That does more than a document.

## Training for the tool itself

A one-hour session for the whole team covering: the instruction file and why it is short, the settings and hooks and what they block, worktrees, the reviewer subagent, and the PR template. Then the tool's own documentation. Zalando runs two training sessions a month; a small team can do one session and a written FAQ.
