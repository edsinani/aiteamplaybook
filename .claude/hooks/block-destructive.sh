#!/usr/bin/env bash
# PreToolUse hook on Bash. Reads the tool call as JSON on stdin and blocks
# destructive commands. Exit code 2 blocks the call and feeds stderr back to
# the agent as the reason. Anything else lets it through.
#
# The deny list in settings.json already covers the exact patterns. This hook
# catches the variants: chained commands, sudo, different flag order, long
# flags. Flags are matched as whole words, so a branch named task/142-fix-login
# is not mistaken for -f.

set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null || true)"

[ -z "$cmd" ] && exit 0

block() {
  echo "Blocked by .claude/hooks/block-destructive.sh: $1" >&2
  echo "This command is not allowed from an agent session. See docs/governance.md." >&2
  exit 2
}

matches() { printf '%s' "$cmd" | grep -Eq "$1"; }

# Start of a command: line start or after a separator, optionally behind sudo.
S='(^|[;&|(][[:space:]]*|[[:space:]])(sudo[[:space:]]+)?'
# Rest of the same command, up to the next separator.
ARGS='([[:space:]]+[^;&|]*)?'
# End of a word.
E='([[:space:]]|$)'

# rm with recursive or force flags, in any order or spelling
if matches "${S}rm${ARGS}[[:space:]](-[a-zA-Z]*[rRf][a-zA-Z]*|--recursive|--force)${E}"; then
  block "recursive or forced rm"
fi

# deleting migrations, with rm or git rm
if matches "${S}(git[[:space:]]+)?rm[[:space:]][^;&|]*[Mm]igrations/"; then
  block "deleting migrations"
fi

# force pushes: -f, combined short flags, --force, --force-with-lease, +refspec
if matches "${S}git${ARGS}[[:space:]]push${ARGS}[[:space:]](-[a-zA-Z]*f[a-zA-Z]*|--force[a-z-]*|\+[^[:space:]]+)${E}"; then
  block "git force push"
fi

# history rewriting and discarding work
if matches "${S}git[[:space:]]+(reset[[:space:]]+--hard|rebase[[:space:]]+(-i|--interactive)|filter-branch|filter-repo|branch[[:space:]]+(-D|--delete[[:space:]]+--force)|clean${ARGS}[[:space:]]-[a-zA-Z]*f)"; then
  block "git history rewrite or discarded work"
fi

# database destruction, only when a database client runs it, so a grep for
# the words is not blocked
if matches "dotnet[[:space:]]+ef[[:space:]]+database[[:space:]]+drop" \
  || { matches "${S}(sqlcmd|psql|mysql|sqlite3|mongosh)${E}" \
       && printf '%s' "$cmd" | grep -Eiq '(drop[[:space:]]+(database|table|schema)|truncate[[:space:]]+table|dropDatabase)'; }; then
  block "database destruction"
fi

# infrastructure destruction
if matches "(docker[[:space:]]+(system[[:space:]]+prune|volume[[:space:]]+(rm|prune))|az[[:space:]]+group[[:space:]]+delete|terraform[[:space:]]+destroy|kubectl[[:space:]]+delete)"; then
  block "infrastructure destruction"
fi

exit 0
