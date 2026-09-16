# Measurement

Start on day one, before anything else changes. The baseline is the point. Without it, the only evidence in six months will be how people feel, and the best randomized study to date found that experienced developers using AI felt 20 percent faster while measuring 19 percent slower (METR, July 2025). Do not put a speed number in a status report that did not come from this file.

## What to record

Five numbers, weekly, from the tracker and the git host. One row per week in `measurement-log.csv` (or the team's dashboard). Nothing here needs a new tool.

| Metric | Source | Why |
|---|---|---|
| PRs merged | git host | The volume that goes up first |
| Median PR size (changed lines, excluding generated) | git host | The thing that grows silently |
| Median time from PR open to merge | git host | The review queue, which is where the cost lands |
| Change failure rate: PRs that needed a fix-forward or revert within 7 days | tracker labels `hotfix`, `revert` | Quality. Bugs per developer rose 54 percent in the Faros 2026 data |
| Rework: PRs with more than two review rounds | git host | The reviewer fatigue signal |

Optional but useful: deploy frequency, and the share of merged PRs with the `claude-code-assisted` label, which turns the metrics above into with and without comparisons.

## What to record per developer, privately

Cost per developer per day from the analytics page or the OpenTelemetry export. This is for the lead to see a looping session, not for ranking people. Say that out loud when the team starts.

## What not to record

Lines of code written. Accept rate of suggestions. Hours "saved" from self-report. None of these predicted delivery outcomes in any published study, and the first two reward the wrong thing.

## When to look

Every Friday, five minutes, in the weekly checkpoint (see `docs/roles-and-rituals.md`). Every milestone, thirty minutes: is PR size creeping up, is merge time creeping up, is the change failure rate holding. The DORA 2025 report found AI adoption raised throughput and lowered stability across 5,000 respondents; the team's job is to be the exception, and this is how it will know.

## What good looks like after one milestone

PRs merged up. Median PR size flat or down, because the 400 limit holds. Merge time flat, because the AI first pass and the tiers absorbed the volume. Change failure rate flat. If the first is up and the rest are flat, the setup is working. If merge time doubled, read `docs/review-policy.md` section 2 again and tune the reviewer before adding people.

## What to show a sponsor

The five weekly numbers as a chart, with the date the playbook was installed marked on it. Nothing else. Any company's published headline percentage came from a setup that is not this team's.
