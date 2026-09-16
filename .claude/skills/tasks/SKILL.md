---
name: tasks
description: Split an approved feature design into tasks. Writes docs/specs/<feature>/tasks.md and produces tracker-ready task entries. Use after design.md is Approved.
---

# /tasks <feature-slug>

Read `docs/specs/<feature-slug>/design.md`. Refuse if its status is not Approved.

1. Derive tasks from the Phases section. One task is one PR under 400 changed lines, one person, under a day. Split anything larger along the seams the design shows: schema, then service, then UI is the usual seam.
2. For each task fill the table row: tracker placeholder, task, Satisfies (requirement numbers from `requirements.md`), Touches (files or folders), Parallel, Status Todo.
3. Contract-changing tasks first, alone, not [P]. Then tasks whose Touches do not overlap, marked [P]. Then dependents.
4. Check coverage: every requirement number appears in at least one task's Satisfies. Every task's Satisfies exists.
5. Produce a tracker entry for each task using the template in `tasks.md`, ready to paste. Fill Verification from the design's questions or from a concrete command. Fill Notes for the agent with the one gotcha a human would say in person, or leave it empty; do not invent one.
6. Run `spec-checker`. Fix gaps.
7. Tell the developer to create the tracker entries and paste the ids back into the table. Then stop.

Never start implementing from this skill. The lead approves tasks first.
