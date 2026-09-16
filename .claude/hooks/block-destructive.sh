#!/usr/bin/env bash
# PreToolUse hook on Bash. Reads the tool call as JSON on stdin and blocks
# destructive commands. Exit code 2 blocks the call and feeds stderr back to
# the agent as the reason. Anything else lets it through.
#
# The deny list in settings.json already covers the exact patterns. This hook
# catches the variants: chained commands, sudo, different flag order.

set -euo pipefail

input="$(cat)"
cmd="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("command",""))' 2>/dev/null || true)"

[ -z "$cmd" ] && exit 0

block() {
  echo "Blocked by .claude/hooks/block-destructive.sh: $1" >&2
  echo "This command is not allowed from an agent session. See docs/governance.md." >&2
  exit 2
}

# rm -rf in any form, including -fr and sudo
if printf '%s' "$cmd" | grep -Eq '(^|[;&|[:space:]])(sudo[[:space:]]+)?rm[[:space:]]+(-[a-zA-Z]*[rf][a-zA-Z]*[[:space:]]+)+'; then
  block "recursive or forced rm"
fi

# history rewriting and force pushes
if printf '%s' "$cmd" | grep -Eq 'git[[:space:]]+(push[[:space:]]+.*(-f|--force)|reset[[:space:]]+--hard|rebase[[:space:]]+-i|filter-branch|branch[[:space:]]+-D)'; then
  block "git history rewrite or force push"
fi

# database and infrastructure destruction
if printf '%s' "$cmd" | grep -Eiq '(drop[[:space:]]+(database|table)|truncate[[:space:]]+table|docker[[:space:]]+(system[[:space:]]+prune|volume[[:space:]]+rm)|az[[:space:]]+group[[:space:]]+delete|terraform[[:space:]]+destroy)'; then
  block "database or infrastructure destruction"
fi

# deleting migrations
if printf '%s' "$cmd" | grep -Eq 'rm[[:space:]]+.*[Mm]igrations/'; then
  block "deleting migrations"
fi

exit 0
