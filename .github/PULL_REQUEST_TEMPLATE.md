## Task

Tracker: #
Spec: docs/specs/<feature>/ (Phase N)
Satisfies: Req
Risk tier: Low | Standard | High
Contract: none | <name, and both guard tests changed>

## What changed

One paragraph. What a developer joining next month needs to know. Not a file list.

## How it was built

Tool: Claude Code | Cursor | Copilot | Kiro | Codex | by hand
Agent asked to: <the task's instruction in one or two lines>
Human changed after the agent: <what, or "nothing">

## Verification

The task's verification line, and the evidence that it is true:

- Req n.n: `<test name>` (passes)
- Command: `<command>` output below
- Screenshot: <path> (for UI work, next to the prototype state it matches)

```
<paste the check output>
```

## Definition of done

- [ ] Check passes locally and in CI, output above
- [ ] Change answers the task's verification line, evidence above
- [ ] Under 400 changed lines, or `size/xl-override` with reason below
- [ ] One task, one branch; unrelated fixes went to the tracker
- [ ] Contracts listed above, guard tests changed if any
- [ ] Migration included if schema changed
- [ ] Nothing named after a test case or fixture value
- [ ] Docs made wrong by this change were fixed here (AGENTS.md, design.md, feature status log)
- [ ] AI first pass ran; every Important finding fixed or answered
- [ ] Prototype deviations, if any, recorded in the feature design

## Override reason (only if over 400 lines)

