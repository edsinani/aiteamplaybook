# The same setup in other tools

Everything in `docs/` is tool-neutral. `AGENTS.md` is read natively by Cursor, Copilot, Codex, Kiro and most others. What changes per tool is where four things live: shared settings and permissions, hooks, subagents and skills, and the AI review. This table is the map; each file has the detail.

| Playbook piece | Claude Code | Cursor | GitHub Copilot | Kiro | Codex |
|---|---|---|---|---|---|
| Instruction file | `CLAUDE.md` imports `AGENTS.md` | `AGENTS.md` native, plus `.cursor/rules/*.mdc` for path-scoped rules | `AGENTS.md` native, plus `.github/copilot-instructions.md` and `.github/instructions/*.instructions.md` | `AGENTS.md` accepted, plus `.kiro/steering/*.md` | `AGENTS.md` native, nested files allowed |
| Shared permissions | `.claude/settings.json` allow, ask, deny | Team Rules in the dashboard (Team and Enterprise); hooks for enforcement | Repository and organization custom instructions; coding agent runs in an ephemeral Actions environment | `.kiro/agents/*.json` tool allow lists | `~/.codex/config.toml` sandbox and approval policy |
| Hooks | `.claude/settings.json` hooks; PreToolUse, PostToolUse, Stop | `.cursor/hooks.json`; beforeShellExecution, afterFileEdit, stop, preToolUse | `.github/hooks/*.json`; preToolUse (can deny), postToolUse, agentStop | `.kiro/hooks/*.json`; PreToolUse, PostToolUse, AgentStop, PostFileSave | Not documented as of September 2026 |
| Subagents | `.claude/agents/*.md` | `.cursor/agents/*.md`; also reads `.claude/agents/` | `.github/agents/*.agent.md` | `.kiro/agents/*.json` or `.md` | `.codex/agents/*.toml` |
| Team commands | `.claude/skills/<name>/SKILL.md` | Rules with `alwaysApply: false` invoked by name; Cloud Agents for background runs | Custom agents selectable when assigning issues | Steering with `manual` inclusion | Instructions in `AGENTS.md` sections |
| Worktrees and parallel work | `claude --worktree <name>` | Cloud Agents run in isolated VMs; local worktrees by hand | Coding agent runs per issue in Actions; local worktrees by hand | Waves: Kiro computes the task dependency graph and runs independent tasks concurrently | Local worktrees by hand |
| AI first-pass review | `.github/workflows/ai-review.yml`, or Claude Code Review with `REVIEW.md` | Bugbot, tuned by `.cursor/BUGBOT.md` (rules do not apply to Bugbot) | Copilot code review; reads `AGENTS.md` and `.github/instructions/` | Not a PR reviewer; use one of the others | `@codex review`; rules in a `## Code Review Rules` section of `AGENTS.md` |
| Spec workflow | `/spec`, `/tasks` skills | Same skills as rules, or GitHub Spec Kit (`specify init --integration cursor`) | Spec Kit, or the cloud agent's built-in research, plan and code flow | Native: `.kiro/specs/<feature>/requirements.md`, `design.md`, `tasks.md` with approval gates and EARS criteria | Spec Kit |

The playbook's `docs/specs/` folder uses Kiro's names on purpose. A team on Kiro can point Kiro at `docs/specs/` or move the folder to `.kiro/specs/`; the files are the same shape.

GitHub Spec Kit works with all five tools and adds `/speckit.constitution`, `/speckit.specify`, `/speckit.plan`, `/speckit.tasks`, `/speckit.analyze` and `/speckit.implement`. Its `constitution.md` is this playbook's `docs/constitution.md`, its `plan.md` is `design.md`, and its `[P]` task markers are the same convention as `tasks.md`. A team that prefers Spec Kit's tooling keeps everything in `docs/` and lets Spec Kit generate into `specs/`.
