@AGENTS.md

# Claude Code notes

Everything an agent needs is in `AGENTS.md`. This file only adds what is specific to Claude Code.

- Work in a worktree: `claude --worktree task-<id>-<slug>`. Worktrees live in `.claude/worktrees/` and are gitignored.
- Before opening a PR, run the reviewer subagent with fresh context: ask for "a review by the reviewer agent". It reads the spec and the diff, not this session's history.
- `/spec`, `/tasks` and `/review` are team skills in `.claude/skills/`. Use them instead of improvising the format.
- The Stop hook runs the project check before you can finish. If it blocks, fix the cause. Do not work around it.
- Permission rules are shared in `.claude/settings.json`. Add personal conveniences to `.claude/settings.local.json`, never remove a deny rule.
