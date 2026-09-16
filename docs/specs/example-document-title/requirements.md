# Document display titles: requirements

Tracker: #128
Author: Developer A
Approved by: Lead, 2026-02-18
Status: Implemented

A worked example, generalized from a real feature. The original was a free-form user story; this is the same story in the template, with acceptance criteria rewritten in EARS form so tasks can cite them.

## User story

As a user reviewing uploaded documents,
I want each document labelled with a title taken from its content,
so that I can identify documents at a glance instead of reading raw filenames.

## Context

Documents show their uploaded filename, cleaned by stripping the extension and humanizing underscores. Filenames like `scan_0042.pdf` tell the reviewer nothing. The extraction pipeline already knows the invoice number, the parties and the route, so the title can be derived at no extra cost. Touches system design section 3 (core flows, step Extract) and section 5 (Document entity).

## Acceptance criteria

### 1. Title derivation

1.1 WHEN a document finishes processing THE SYSTEM SHALL store a `displayTitle` on the document derived from extracted fields.
1.2 WHEN the document type is Invoice THE SYSTEM SHALL derive the title as "Invoice <number>, <shipper>".
1.3 WHEN the document type is Bill of Lading THE SYSTEM SHALL derive the title as "BOL <number>, <origin> to <destination>".
1.4 WHEN the document type is unknown THE SYSTEM SHALL derive the title from the first heading or the most prominent text block.
1.5 IF processing fails or no title can be derived THEN THE SYSTEM SHALL leave `displayTitle` empty.

### 2. Display

2.1 WHERE `displayTitle` is present THE SYSTEM SHALL show it in place of the filename in every document list and detail view.
2.2 WHILE `displayTitle` is empty THE SYSTEM SHALL show the cleaned filename.

### 3. Search

3.1 THE SYSTEM SHALL include `displayTitle` in document list search.

## Out of scope

Editing the title by hand. Re-deriving titles for documents processed before this feature.

## Open questions

None. (Closed before approval: "Should the title include the date?" No. The list already shows the upload date.)

## Priority and risk tier

Priority: Medium. The cleaned filename is a workable interim.
Risk tier: Low. Additive nullable field, no contract change, no auth or billing path.
