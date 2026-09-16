# Definition of done

A task is done when every line below is true. The PR template repeats these as checkboxes. The Stop hook enforces the first one before the agent can say it is finished.

## For every task

1. The check passes. The project's test command runs green locally and in CI. The agent shows the output; it does not assert success.
2. The change answers the question the task asked. Not "the code runs" but "the verification line in the task is true". If the task said "an uploaded invoice shows its number in the list", the PR includes the evidence: a test that asserts it, a screenshot, or a command and its output.
3. The PR is under 400 changed lines, or carries `size/xl-override` with a reason in the description. See `docs/review-policy.md` for why 400.
4. One task, one branch, one PR. Unrelated fixes discovered on the way became their own tracker entries and are not in this diff.
5. Contracts touched are listed in the PR and both guard tests changed with them. If none, the PR says "Contract: none".
6. Schema changes ship with their migration in the same PR.
7. Nothing derived from a specific failing test case was added to make it pass. If the agent proposed a rule, mechanism or fix named after one test, it was surfaced to a human first.
8. The docs that the change made wrong were fixed in the same PR: `AGENTS.md` if a command or convention changed, `docs/design.md` if the shape of the system changed, the feature `design.md` status log always.
9. The AI first-pass review ran and every Important finding was either fixed or answered in a comment.
10. A human reviewed according to the risk tier.

## For the last task of a feature

11. The verification questions in the feature design were answered, in the PR, with evidence.
12. The feature `design.md` status is Implemented and `tasks.md` shows every row Done.
13. Anything descoped is written in the design's deviations section, not silently dropped.

## Why a rule about tests named after failing cases

Agents under pressure to make a red test green will add a special case. It passes, and it is wrong. The rule comes from one developer's instruction file after seeing it happen: "If you catch yourself adding a rule, mechanism or fix named after a specific failing test case, stop. Surface the pattern before writing the code." The reviewer's job is to look for those. A good tell is a condition that mentions a value from a fixture.

## What done is not

Done is not "the agent said it was done". Done is not "the PR is open". Done is not "it works on my machine". Every one of those has cost a team a week.
