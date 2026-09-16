# Kiro

Kiro is the tool this playbook's spec vocabulary comes from. A Kiro team gets the spec workflow natively and needs the playbook mostly for the review policy, governance and measurement.

## Instruction files

`AGENTS.md` is accepted. Kiro's own mechanism is steering: `.kiro/steering/product.md`, `tech.md`, `structure.md` by default, plus any others. Inclusion modes are `always`, `fileMatch`, `manual` and `auto`. Map the playbook this way:

- `docs/constitution.md` becomes `.kiro/steering/tech.md` (always).
- The purpose paragraph and deliberate limits become `.kiro/steering/product.md` (always).
- The "Where things are" section of `AGENTS.md` becomes `.kiro/steering/structure.md` (always).
- Path-specific rules use `fileMatch`.

Or keep `AGENTS.md` as the single source and make each steering file one line pointing at it. Inclusion modes are not supported in the Kiro CLI, only the IDE.

## Specs

Native. `.kiro/specs/<feature>/requirements.md`, `design.md`, `tasks.md`, with an approval gate between each. Requirements use EARS ("WHEN [condition] THE SYSTEM SHALL [behavior]") and tasks cite them as `_Requirements: 1.1_`. The playbook's `docs/specs/_template/` is the same shape with two additions Kiro does not prescribe: the `Touches` and `Do not touch` lines per task, and the risk tier. Add both to Kiro's tasks so the review policy can use them.

Either move `docs/specs/` to `.kiro/specs/` or point Kiro at `docs/specs/`. Keep the worked example.

## Hooks

`.kiro/hooks/<name>.json`. Twelve triggers including `PreToolUse`, `PostToolUse`, `AgentStop`, `PostFileSave`, `PromptSubmit`, `PreTaskExecution`. Map the three playbook hooks to `PreToolUse` (block-destructive), `PostFileSave` (lint-on-edit) and `AgentStop` (stop-gate). Check the stdin shape in the Kiro docs and adjust the extraction lines.

## Custom agents

`.kiro/agents/<name>.json` or `.md`, with tool allow lists per agent. This is also where Kiro's version of the permission list lives: give the default agent the allow list from `.claude/settings.json` and give `reviewer` read-only tools. Custom agents can be invoked as sub-agents in parallel.

## Parallel work

Waves. Kiro reads `tasks.md`, computes the dependency graph and runs independent tasks concurrently. The `[P]` markers in the playbook's tasks become redundant, but the `Touches` overlap check still matters because Kiro infers dependencies from the task text, not from file lists. State the dependency in the task if it is not obvious.

## AI review

Kiro is not a PR reviewer. Use Copilot code review, Bugbot, Claude Code Review or the playbook's `ai-review.yml` workflow on the git host.
