#!/usr/bin/env bash
# Stop hook. Runs before the agent is allowed to finish its turn. If the
# project check fails, exit 2 and the agent keeps working with the failure
# output as its next instruction. This is the deterministic version of
# "verify before declaring done".
#
# Only runs when the session changed source files. Set CHECK below to the
# project's real, fast command. Keep it under a few minutes; the full suite
# belongs in CI. Until CHECK is set, the gate blocks with a message saying so,
# so an unconfigured gate is never mistaken for a passing one.
#
# Loop guard: the gate blocks up to MAX_BLOCKS times in a row per session.
# After that it lets the agent stop and tells the developer the check is still
# red. CI runs the check again on the pull request either way.

set -uo pipefail

# TODO: the project's check. Examples:
#   CHECK="dotnet test --no-restore"
#   CHECK="cd worker && pytest -q"
#   CHECK="cd frontend && npm run type-check && npm test -- --run"
# PLAYBOOK_CHECK in the environment overrides it.
CHECK="${PLAYBOOK_CHECK:-}"
MAX_BLOCKS=3

input="$(cat)"
session="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("session_id","default"))' 2>/dev/null || echo default)"
counter="${TMPDIR:-/tmp}/playbook-stop-gate-${session//[^a-zA-Z0-9_-]/}"

cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

# Nothing changed in source, nothing to check.
if git diff --quiet HEAD -- . ':(exclude)*.md' ':(exclude)docs/**' 2>/dev/null \
  && [ -z "$(git ls-files --others --exclude-standard -- . ':(exclude)*.md' ':(exclude)docs/**' 2>/dev/null)" ]; then
  rm -f "$counter"
  exit 0
fi

if [ -z "$CHECK" ]; then
  status=1
  out="The stop gate is not configured. Set CHECK in .claude/hooks/stop-gate.sh (README install step 5). Tell the developer; do not work around it."
else
  out="$(bash -c "$CHECK" 2>&1)"
  status=$?
fi

if [ $status -eq 0 ]; then
  rm -f "$counter"
  exit 0
fi

blocks=$(( $(cat "$counter" 2>/dev/null || echo 0) + 1 ))
if [ "$blocks" -gt "$MAX_BLOCKS" ]; then
  rm -f "$counter"
  echo "Stop gate: the check is still failing after $MAX_BLOCKS attempts. Stopping so a human can look. The task is not done." >&2
  echo "Stop gate: the check is still failing after $MAX_BLOCKS attempts. The task is not done."
  exit 0
fi
echo "$blocks" > "$counter"

{
  echo "Stop gate ($blocks of $MAX_BLOCKS): the project check failed. Fix it before finishing."
  [ -n "$CHECK" ] && echo "Command: $CHECK"
  echo "$out" | tail -60
} >&2
exit 2
