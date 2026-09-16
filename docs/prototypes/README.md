# Walkable demos

The rule: no user-facing code is written until a clickable prototype of the screens exists and the lead has walked through it. The prototype is the visual target. The feature design links to it and lists every deliberate deviation.

No vendor has a name for this practice. It comes from one developer's experience that agents build the right UI the first time when they have a picture to build toward, and build it three times when they have a paragraph.

## What a prototype is

A single self-contained file that renders the screens with realistic mock data and lets a person click between states. React with Tailwind classes is a good default because agents produce it quickly and it renders in any sandbox. The app itself may be Vue or anything else; the prototype is throwaway design, not app code.

## What a prototype is not

Not pixel-perfect. Not responsive unless the feature is about responsiveness. Not dark mode unless the feature is about dark mode. Not connected to real data.

## Where it lives

`docs/prototypes/<feature>.jsx`, committed, and kept after the feature ships. The prototype is the record of what was agreed. Deleting it deletes the reason the implementation looks the way it does.

## Required header

Every prototype starts with a comment block that answers four questions. Example, generalized from a real one:

```jsx
/**
 * Design prototype: shipment consistency findings.
 *
 * Screens behind the tab switcher:
 *   1. Inbox: descriptive status labels, pending split, filter captions.
 *   2. Shipment detail: documents left, checklist right on large screens,
 *      stacked on small. Inline expanding checklist replaces the overlay drawer.
 *   3. Document issues: cross-document findings shown from this document's
 *      point of view.
 *
 * Mirrors: DocumentDetailView's two-column layout and sticky pane. Colors
 * from frontend/tailwind.config.js. Radii follow the app scale.
 *
 * Deliberately omitted: dark mode (implementation uses dark: variants as
 * everywhere else), the "Mark verified" button (acknowledgement is unscoped).
 *
 * Doubles as a spec for: the `observations` evidence shape the rules emit.
 *   See docs/specs/shipment-consistency/design.md.
 *
 * Not app code. The app is Vue. This is a throwaway design artifact.
 */
```

The four questions: which screens, what it mirrors from the existing app, what is deliberately left out, and what else it specifies.

## How the walkthrough goes

The developer opens the prototype, the lead clicks through every state and asks the verification questions from the design ("can a tester say what each tab means without asking?"). Changes are made to the prototype, not to a document about the prototype. When the lead says yes, the design's Prototype line gets the file path and the date, and implementation can start.

## How the agent uses it

The implementation task points the agent at the prototype file and the design's deviations list. The instruction is: "Build the Vue implementation of screen 2 from `docs/prototypes/<feature>.jsx`. Use the app's components where the prototype mirrors them. Do not add anything the prototype does not show." Screenshots of the prototype states can be attached where the tool supports images.

## When a product or UX team owns the design

A Figma prototype counts, and it is often better than anything the developer would build. Three things change.

1. The agent cannot read a Figma link. Export every state the prototype covers as an image and commit the images under `docs/prototypes/<feature>/`, with a short `README.md` that answers the same four questions as the header above. If the team runs the Figma MCP server, the agent can read the file directly; the export still gets committed.
2. The export is the record, not the link. A Figma file keeps changing after the walkthrough. The committed images are what was agreed on the day. The design's Prototype line carries both the link and the export path.
3. The walkthrough includes the designer. Deviations still go into the design's deviations section, agreed with the designer, so the implementation and the Figma file do not drift apart without anyone noticing.

The implementation task then points the agent at the exported states instead of a `.jsx` file: "Build screen 2 from the images in `docs/prototypes/<feature>/`. Use the app's components where the design mirrors them. Do not add anything the design does not show."

## Other tools

The practice is tool-neutral. For Cursor and Copilot, attach the prototype file to the chat context or reference it in the task. For Kiro, link it from `design.md` in the spec folder. Kiro's design approval gate is the natural place for the walkthrough.
