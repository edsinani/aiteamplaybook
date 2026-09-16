---
name: spec
description: Start a feature spec. Creates docs/specs/<feature>/requirements.md and design.md from the templates, interviews the developer for the content, and runs the spec-checker before the lead's gate review. Use when a feature has no spec folder yet.
---

# /spec <feature-slug>

Create `docs/specs/<feature-slug>/` from `docs/specs/_template/`. Then fill it in with the developer, one gate at a time.

## Requirements first

1. Ask for the user story in one exchange: who, what capability, what observable outcome. Do not accept a technical description as the story.
2. Ask what exists today and why it is not enough. Write the Context section. Link the `docs/design.md` section it touches.
3. Draft acceptance criteria in EARS form, grouped and numbered. Read them back. Push on anything that is not testable: "how would a tester know?"
4. Ask what is deliberately out of scope. Write at least two items.
5. List open questions. Each one has an owner. Do not proceed to design while any is open.
6. Propose a risk tier from the table in `docs/review-policy.md` with a one-line reason. The developer confirms.
7. Run the `spec-checker` agent on the file. Fix the gaps. Tell the developer it is ready for the lead's gate review and stop.

## Design, after the lead approves requirements

1. Read `docs/design.md` and the constitution. Draft the Approach paragraph.
2. Ask the lead's decisions already taken. Write them as bullets so the implementer does not reopen them.
3. For each component that changes: what, which contract, which tests. If a contract changes, say so prominently and mark it as its own first task.
4. Data changes and migrations.
5. Phases that each leave the system working. Mark independent ones.
6. If user-facing: ask for the prototype path, or the Figma link and the path of the exported states under `docs/prototypes/<feature>/`. If there is neither, stop and point at `docs/prototypes/README.md`. Do not draft UI code.
7. Verification as questions a tester answers. Derive them from the acceptance criteria.
8. Run `spec-checker`. Fix gaps. Ready for the lead's gate review. Stop.

Then `/tasks`.

Never write implementation code from this skill. Never skip a gate because the developer is confident.
