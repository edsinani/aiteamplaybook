# <Feature name>: requirements

Tracker: <epic or parent issue link>
Author: <developer>
Approved by: <lead>, <date>
Status: Draft | Approved | Implemented | Archived

Written by the developer who will build the feature. Approved by the lead before design starts. This is the first of Kiro's three gates.

## User story

As a <role>,
I want <capability>,
so that <outcome the user can observe>.

## Context

Two to five sentences. What exists today, why it is not enough, what triggered this now. Link the system design section it touches.

## Acceptance criteria

Write every criterion in EARS form so it can be tested and cited by a task. Number them; tasks reference them as `Req 1.2`.

EARS has five patterns. Use the one that fits.

- Ubiquitous: THE SYSTEM SHALL <behavior>.
- Event-driven: WHEN <trigger> THE SYSTEM SHALL <behavior>.
- State-driven: WHILE <state> THE SYSTEM SHALL <behavior>.
- Optional feature: WHERE <feature is present> THE SYSTEM SHALL <behavior>.
- Unwanted behavior: IF <condition> THEN THE SYSTEM SHALL <behavior>.

### 1. <Group name>

1.1 WHEN <trigger> THE SYSTEM SHALL <behavior>.
1.2 IF <failure condition> THEN THE SYSTEM SHALL <fallback>.

### 2. <Group name>

2.1 THE SYSTEM SHALL <behavior>.

## Out of scope

What this feature deliberately does not do. This section is what stops an agent from adding it anyway.

## Open questions

Questions that block design. Each one has an owner and is closed before approval. An approved requirements document has an empty list here.

## Priority and risk tier

Priority: Critical | High | Medium | Low.
Risk tier (see `docs/review-policy.md`): Low | Standard | High. Say why in one line.
