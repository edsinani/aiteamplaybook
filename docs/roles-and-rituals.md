# Roles and rituals

For a team of three to six developers and one lead. Nobody gets a new title. What changes is what the existing roles own.

## The lead

Owns the constitution, the system design and ADR approval. Owns agent configuration (see `docs/governance.md`). Approves each feature at the three gates: requirements, design, tasks (the tasks gate may be delegated, see Rituals). Reviews every High-tier PR. Runs the weekly checkpoint and reads the measurement file.

What the lead stops doing: writing most of the code, and writing every story. The lead's leverage moved from the keyboard to the design document and the gates.

## Every developer

Writes the requirements, design and tasks for the features they build, and takes them through the gates. Runs one worktree per task and one PR per task. Owns the AI review findings on their own PRs. Reviews Standard-tier PRs from teammates. Keeps `AGENTS.md` and the design current when their change makes them wrong.

## The reviewer of record

Rotates per milestone. One developer who reads the system design at the start of the milestone and reviews every change to it during the milestone. This is the second pair of eyes on the lead's document and the way the design stops living in one head.

## Pairs for High-tier work

High-tier tasks (auth, billing, migrations, contracts, prod config) are reviewed by the lead and one other. Rotate the other. Everyone should have seen the sharp edges.

## Rituals

Keep the ones that make a decision or catch a drift. Drop the rest. Agents make the daily standup less useful because progress is visible in the tracker and the PR queue.

Milestone planning, every two to four weeks, one hour. The lead presents the features for the milestone. Each developer takes one and commits to having requirements approved within two days. Contract-changing tasks are identified and sequenced first.

Gate reviews, as needed, fifteen minutes each. Developer and lead, on the requirements, then the design (with the walkable demo if user-facing), then the tasks. Async is fine for requirements. The design walkthrough is better live. The lead answers a gate within one working day; a gate that waits longer than that is the lead's blocker to raise at the checkpoint. With five or six developers, the lead may delegate the tasks gate to the reviewer of record for the milestone, keeping requirements and design.

Weekly checkpoint, Friday, twenty minutes, whole team. Four questions, taken from a solo developer's tracker and still the right four:

1. Can we demo what we built this week?
2. Is there a blocker someone is avoiding?
3. Are we building something not on the plan?
4. What is the one thing for next week?

Then five minutes on the measurement numbers: PR size, merge time, failure rate.

Milestone retro, thirty minutes. What the AI reviewer flagged that humans missed and the reverse. Which template was awkward. Which rule in `AGENTS.md` nobody needed. Which hook fired most. Retire and add accordingly. The playbook is meant to shrink over time, not grow.

## What is deliberately absent

A dedicated "prompt engineer" or "AI champion" role. The published, measured setups we draw on do not rely on one. What they have is a platform or enablement group at scale, and on a small team that group is the lead's configuration ownership plus this document.
