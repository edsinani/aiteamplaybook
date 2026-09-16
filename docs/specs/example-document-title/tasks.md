# Document display titles: tasks

Design: `./design.md` (Approved 2026-02-18)
Tracker: milestone "Week 09"
Approved by: Lead, 2026-02-18

## Tasks

| # | Tracker | Task | Satisfies | Touches | Parallel | Status |
|---|---|---|---|---|---|---|
| 1 | #128-1 | Add `DisplayTitle` to entity, migration, DTO, search | Req 3.1 | `Domain/Document.cs`, `Migrations/`, `Dtos/`, `DocumentsController` search | No, schema first | Done |
| 2 | #128-2 | Derive titles in worker by document type | Req 1.1 to 1.5 | `worker/app/title_derivation.py`, pipeline call site, tests | [P] with 3 | Done |
| 3 | #128-3 | Frontend `documentTitle` helper and call sites | Req 2.1, 2.2 | `frontend/src/utils/documentTitle.ts`, views | [P] with 2, after 1 | Done |

## Example tracker entry (task 2)

```
Title: Derive display titles in the worker by document type
Satisfies: Req 1.1, 1.2, 1.3, 1.4, 1.5
Design: docs/specs/example-document-title/design.md, Phase 2
Touches: worker/app/title_derivation.py (new), worker/app/pipeline.py (one call after normalization), worker/tests/test_title_derivation.py (new)
Do not touch: the normalization schemas, the results writer
Contract: none
Risk tier: Low
Verification: pytest worker/tests/test_title_derivation.py passes; an uploaded invoice fixture shows "Invoice <number>, <shipper>" in the list
Notes for the agent: the extraction for a bill of lading has origin and destination under port_of_loading and port_of_discharge, not origin/destination.
```

## Order

1. Task 1 alone (schema).
2. Tasks 2 and 3 in parallel, each in its own worktree.

## Done when

All three Done, the three verification questions answered in the PR for task 3, and `design.md` marked Implemented.
