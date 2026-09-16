# Review policy

Review is where teams using agents get stuck. Across 22,000 developers over two years, moving from low to high AI adoption raised PRs merged per developer 16 percent, raised median time in review more than five times, raised bugs per developer 54 percent, and raised the share of PRs merged with no review at all 31 percent (Faros AI, "The AI Engineering Report 2026"). The year before, the same telemetry showed PRs merged nearly doubling and PR size growing 154 percent on high-adoption teams (Faros AI, "The AI Productivity Paradox", 2025). Every team that has published a working setup did the same three things: capped PR size, put an AI reviewer first, and tiered PRs by risk so the human queue only holds what needs a human. This policy does those three things.

## 1. PR size: 400 changed lines

Hard limit, enforced by the CI check `pr-size`. Over the limit, the check fails unless the PR carries the label `size/xl-override` and the description says why.

Why 400. In a study of 107,026 agent-authored pull requests, the smallest tenth (a median of two changed lines) conflicted on merge about 10 percent of the time, and PRs of 46 to 185 changed lines conflicted 32 to 33 percent of the time (AgenticFlict, arXiv 2604.03551, April 2026). Reviewers also do measurably more rounds on agent-written code, 11.8 percent more across 300 open-source projects (arXiv 2603.15911). Both costs grow with size, and both are paid by a human. 400 is the point where a careful reviewer can still hold the whole diff in their head in one sitting. Zalando's teams, after watching agent PRs grow, agreed fixed size limits among themselves rather than enforcing them with tooling (Zalando Engineering, "Agentic Engineering at Zalando: a snapshot", August 2026). Teams that want a different number should write the reason here.

What to do when a task will not fit: split it. The task template's `Touches` line usually shows the seam. A migration plus its code plus its UI is three PRs, merged in order.

Generated files (lockfiles, snapshots, manifests) are excluded from the count by the check.

## 2. AI first pass

Every PR gets an automated review before a human looks at it. The workflow is `.github/workflows/ai-review.yml`. It reads `AGENTS.md`, the constitution and the linked spec, and posts findings inline tagged Important, Nit or Pre-existing.

What the first pass is for: conformance to the design and the constitution, missing tests for a cited requirement, contract changes without both guard tests, fixes named after a test case, secrets, obvious defects. What it is not for: style already covered by the linter, or opinions.

Rules that keep it trusted, learned by the teams who ran it at scale:

- Cap the noise. Uber's uReview covers more than 90 percent of roughly 65,000 weekly diffs with 75 percent of comments rated useful, behind filtering, validation and deduplication stages (Uber Engineering, "uReview", 2025). HubSpot added a second "judge" agent that filters the first reviewer's comments for succinctness, accuracy and actionability before posting (HubSpot Engineering, "Automated Code Review: The 6-Month Evolution", 2026). Start with Important findings only and nits capped at three.
- Watch closure time. In one industrial study, average PR closure time rose from 5 hours 52 minutes to 8 hours 20 minutes after an LLM-based reviewer was introduced ("Automated Code Review In Practice", ICSE 2025, arXiv 2412.18531). If that happens, the reviewer is too chatty, not the developers too slow.
- The author answers every Important finding, with a fix or a one-line reason. Dismissed findings are data for tuning.
- Tune it in the repo. Claude Code Review reads a `REVIEW.md` for severity rules, skip paths and always-check rules. Cursor's Bugbot reads `.cursor/BUGBOT.md`. Codex reads a `## Code Review Rules` section in `AGENTS.md`. Copilot's review reads `AGENTS.md` and `.github/instructions/`.

## 3. Risk tiers

Every task carries a tier from the task template. The tier decides who reviews.

| Tier | What is in it | AI review | Human review | Merge |
|---|---|---|---|---|
| Low | Additive, reversible, no contract, no auth, no money, no data migration, no prod config. Copy changes, new tests, internal refactors under 100 lines, docs. | Required | Any team member, may be light | After green CI and one approval |
| Standard | Everything not Low or High. | Required | One team member who did not write it, reading for design conformance and the verification evidence | After green CI and one approval |
| High | Auth, permissions, billing and payments, data migrations that change or delete, anything under `contracts/`, prod infrastructure and secrets handling, external integrations that send data out. | Required | The lead, plus one other. The lead checks the verification evidence personally. | After green CI and both approvals |

Tier is set by the author in the task and checked by the reviewer. When in doubt, go up a tier. A typo in configuration metadata caused an incident at Zalando; their risk tool now rates that kind of change high.

Auto-approval for Low. Not on day one. After the team has run the policy for a full milestone and the measurement file shows the AI first pass catching what humans catch on Low PRs, the lead may switch Low to "AI review plus green CI merges without a human". Zalando auto-approves the 33 percent of PRs its risk tool rates low and measured a 20 to 40 percent cut in PR lead time. Anthropic tiers its codebase by risk, logs every automated approval with the signals it used, and human-reviews a risk-weighted sample (Anthropic, "How Anthropic secures its AI-native software development lifecycle", July 2026). Do the same: keep the sample, and write the switch-on date in `docs/governance.md`.

## 4. What the human looks at

The human reviewer is not a second linter. In order:

1. Does the diff do what the task's verification line says, and is the evidence in the PR?
2. Does it conform to the feature design and the constitution's non-negotiables?
3. Is anything in it named after a test case, a fixture value or a single input?
4. Did the AI first pass flag anything the author dismissed, and was the reason good?
5. Would a developer joining next month understand this change from the PR description alone?

If a reviewer cannot answer question 1 from the PR, the PR goes back. That is the single most useful habit for a team using agents.

## 5. The writer and reviewer are different sessions

When one agent both writes and reviews code in the same context it grades its own homework. Anthropic's guidance is one session to implement and a second session with fresh context to review. The `.claude/agents/reviewer.md` subagent exists for this. Run it before opening the PR; it catches the obvious things so the AI first pass and the human see fewer of them.
