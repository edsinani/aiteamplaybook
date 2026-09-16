# Document display titles: design

Requirements: `./requirements.md` (Approved 2026-02-18)
Prototype: not required. No new screen; an existing text slot changes content.
Approved by: Lead, 2026-02-18
Status: Implemented

## Approach

Add a nullable `DisplayTitle` to the Document entity. Populate it in the worker's post-extraction step using a type-aware derivation. The frontend prefers it over the cleaned filename through one helper so no view needs to know the rule. No contract changes: the field is added to the existing document DTO, which the frontend already tolerates gaining fields.

## Decisions already taken

- Derivation runs in the worker, not the API. The worker already has the typed extraction in memory.
- The title is stored, not computed on read. Lists must stay fast and searchable.
- No manual editing in this feature.

## Changes by component

### Worker service

- Change: `title_derivation.py` with one function per document type and a generic fallback; called from the pipeline after normalization.
- Contract touched: none. Writes to an existing nullable column through the existing results writer.
- Tests: one per document type with a fixture extraction, one for the fallback, one for the failure path leaving the field empty (Req 1.1 to 1.5).

### API

- Change: `DisplayTitle` on the entity, the DTO and the list search predicate.
- Contract touched: none. Additive field on the document DTO.
- Tests: search includes title (Req 3.1); DTO maps null correctly.

### Frontend

- Change: `documentTitle(doc)` helper returning `doc.displayTitle || formatFileName(doc.fileName)`; every view that showed `formatFileName(doc.fileName)` calls the helper.
- Contract touched: none.
- Tests: helper with and without a title (Req 2.1, 2.2).

## Data changes

Migration adding `DisplayTitle NVARCHAR(200) NULL` to `Documents`. No backfill (out of scope).

## Phases

1. Phase 1: entity, migration, DTO, search. Independent.
2. Phase 2: worker derivation and tests. Independent of Phase 1 in code, but only observable after it.
3. Phase 3: frontend helper. Depends on Phase 1 for the field to exist in the DTO.

## Deliberate deviations from the prototype

None. No prototype.

## Verification

Upload one invoice, one bill of lading and one scanned page with no structure, wait for processing, then check:

- Does the invoice show "Invoice <number>, <shipper>" in the list without opening it?
- Does the unstructured scan still show its cleaned filename rather than a blank?
- Does searching for the shipper's name find the invoice?

## Status log

2026-02-18: Phases 1 to 3 implemented in #128. Fallback title from first heading produced noisy results on scanned pages; generic fallback restricted to text blocks over 12 characters.
