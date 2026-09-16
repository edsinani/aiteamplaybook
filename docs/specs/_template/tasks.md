# <Feature name>: tasks

Design: `./design.md` (must be Approved)
Tracker: <milestone or epic link>
Approved by: <lead>, <date>

The third gate. This file is the high-level mirror. The detail for each task lives in the tracker the team uses (GitHub Issues, Jira, Bitbucket). The rule: the tracker holds the conversation, this file holds the shape. When they disagree, the tracker wins and this file gets fixed.

## Sizing rule

One task is one PR, under 400 changed lines, done by one person with one agent session in under a day. If a task cannot be described in the template below without a second paragraph, split it.

## Tasks

Mark `[P]` on tasks that can run in parallel with their neighbours because they touch different files and different contracts. Anything that changes a contract runs first, alone.

| # | Tracker | Task | Satisfies | Touches | Parallel | Status |
|---|---|---|---|---|---|---|
| 1 | #142 | Add `observations` to rule results | Req 1.1, 1.2 | `Rules/*`, contract `rule-result` | No, contract change | Done |
| 2 | #143 | Persist Info severity as Info | Req 2.1 | `Evaluator` | [P] after 1 | In progress |
| 3 | #144 | Findings endpoint on documents | Req 3.1 | `DocumentsController`, tests | [P] after 1 | Todo |
| 4 | #145 | Inbox tabs and captions | Req 4.1, 4.2 | `frontend/views/Inbox*` | [P] after 1 | Todo |

## Task template (paste into the tracker)

```
Title: <verb> <thing>
Satisfies: Req <n.n>, <n.n>
Design: docs/specs/<feature>/design.md, Phase <n>
Touches: <files or folders the agent is expected to change>
Do not touch: <anything nearby that must stay as is>
Contract: <none | name of the contract this changes>
Risk tier: Low | Standard | High
Verification: <the question from design.md this task answers, or the command that proves it>
Notes for the agent: <the one gotcha a human would mention in person>
```

The `Touches` and `Do not touch` lines are what make parallel work safe. Two tasks whose `Touches` lists overlap are not `[P]`.

## Order

1. Contract-changing tasks first, one at a time, merged before anything depends on them.
2. Then the `[P]` group, each in its own worktree.
3. Then anything that depends on the `[P]` group.

## Done when

Every row is Done, the design's verification questions are answered in the last PR, and `design.md` status is Implemented.
