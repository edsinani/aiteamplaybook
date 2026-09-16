#!/usr/bin/env bash
# Stop hook. Runs before the agent is allowed to finish its turn. If the
# project check fails, exit 2 and the agent keeps working with the failure
# output as its next instruction. This is the deterministic version of
# "verify before declaring done".
#
# Guard against loops: the hook input carries stop_hook_active=true when the
# agent is already continuing because of this hook. Claude Code stops
# re-invoking after several consecutive blocks anyway.
#
# Only runs when the session touched source files. Edit CHECK to the
# project's real, fast command. Keep it under a few minutes; the full suite
# belongs in CI.

set -uo pipefail

input="$(cat)"
active="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("stop_hook_active",False))' 2>/dev/null || echo False)"
[ "$active" = "True" ] && exit 0

cd "${CLAUDE_PROJECT_DIR:-.}" || exit 0

# Nothing changed in source, nothing to check.
if git diff --quiet HEAD -- . ':(exclude)*.md' ':(exclude)docs/**' 2>/dev/null && [ -z "$(git ls-files --others --exclude-standard -- . ':(exclude)*.md' 2>/dev/null)" ]; then
  exit 0
fi

# TODO: replace with the project's check. Examples:
#   CHECK="dotnet test --no-restore"
#   CHECK="cd worker && pytest -q"
#   CHECK="cd frontend && npm run type-check && npm test -- --run"
CHECK="${PLAYBOOK_CHECK:-echo 'stop-gate: PLAYBOOK_CHECK not set, edit .claude/hooks/stop-gate.sh' }"

out="$(bash -c "$CHECK" 2>&1)"
status=$?

if [ $status -ne 0 ]; then
  {
    echo "Stop gate: the project check failed. Fix it before finishing."
    echo "Command: $CHECK"
    echo "$out" | tail -60
  } >&2
  exit 2
fi

exit 0
