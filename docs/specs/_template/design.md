# <Feature name>: design

Requirements: `./requirements.md` (must be Approved)
Prototype: `docs/prototypes/<feature>.jsx`, or a Figma link plus the exported states under `docs/prototypes/<feature>/` (required for user-facing work, see `docs/prototypes/README.md`)
Approved by: <lead>, <date>
Status: Draft | Approved | Implemented | Archived

The feature-level design. Links to the system design; never repeats it. The second of the three gates. When the feature ships, the status becomes Implemented and the file stays. Nothing here is deleted; it is the record of why the code looks the way it does.

## Approach

One paragraph. How the feature fits the system, which components change, which do not.

## Decisions already taken

Bullet the decisions the lead has already made so the agent does not reopen them. Example: "Per-document findings surface on both the shipment page and the document page. Severity vocabulary is shared with the document side."

## Changes by component

One subsection per component that changes. For each: what changes, the contract it touches, and the tests that prove it.

### <Component>

- Change:
- Contract touched (see `docs/contracts.md`):
- Tests:

## Data changes

Migrations, new fields, backfills. Every schema change ships in the same PR as the code that needs it.

## Phases

Split the work into phases that can each be merged on their own and leave the system working. Say which phases are independent. This is what `tasks.md` is derived from.

1. Phase 1: <name>. Independent.
2. Phase 2: <name>. Depends on Phase 1.

## Deliberate deviations from the prototype

When the implementation will differ from the walkable demo, say so here and why. Example: "No 'N checks passed' summary row. The report persists only fired rules, so the count is not knowable without a registry endpoint."

## Verification

Write this as the questions a tester answers, not as a list of tests to run. Example:

Seed a shipment with a known consignee mismatch and a missing export date, re-evaluate, then check:

- Inbox: can a tester say what each tab means without asking?
- Shipment page: does the mismatch name both documents and both values inline?
- Document page: does the same finding appear phrased from that document's perspective?

These questions become the definition of done for the feature and the checklist in each PR.

## Status log

Append a dated line each time a phase lands. Example: "2026-06-04: Phase 1 implemented. All 16 rules emit observations at bumped versions."
