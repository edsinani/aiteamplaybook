# ADR-0001: Use a hosted document-intelligence API as the MVP extraction engine

Date: 2026-01-20
Status: Accepted (revisited in ADR-0007 when custom models shipped)
Deciders: Lead

This is a worked example, generalized from a real product. Replace it with your own first decision.

## Context

The product extracts structured fields from uploaded trade documents. Custom models need training data, and there is none on day one. The team is one person for the first twelve weeks. Accuracy on the first customer's documents matters more than cost per page.

## Decision

We use the hosted document-intelligence API's prebuilt invoice model for extraction in the MVP, behind an interface that the worker service owns. Human corrections made in the review queue are stored as training data from the first day. Custom models replace the hosted API per document type once enough corrections exist.

## Options considered

| Option | Why not |
|---|---|
| Custom OCR plus rule-based parsing from day one | Weeks of work before any customer sees output; brittle on layouts we have not seen |
| Custom ML models from day one | No training data; the cold-start problem this decision exists to solve |
| Hosted API with no abstraction | Locks the pipeline to one vendor's field names; the swap later becomes a rewrite |

## Consequences

Easier: high accuracy on the first customer's documents with no training data. The review queue collects corrections from week one.

Harder: the normalization layer between the vendor's schema and ours has to exist from the start and be tested. Per-page cost is higher than self-hosted until volume justifies the switch.

Revisit when: 500 reviewed corrections exist for any one document type, or the hosted API's pricing or terms change.

## Links

System design section 3 (core flows). Feature spec `docs/specs/extraction-pipeline/`.
