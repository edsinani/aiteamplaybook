#!/usr/bin/env bash
# PostToolUse hook on Edit|Write. Formats or lints the file the agent just
# touched, by extension. Fast and quiet on success. Exit 0 always: a lint
# failure is reported to the agent through stdout, not by blocking, so the
# agent sees it and fixes it in the next step.
#
# Adjust the commands to the project's real tools.

set -uo pipefail

input="$(cat)"
file="$(printf '%s' "$input" | python3 -c 'import json,sys; print(json.load(sys.stdin).get("tool_input",{}).get("file_path",""))' 2>/dev/null || true)"

[ -z "$file" ] || [ ! -f "$file" ] && exit 0

case "$file" in
  *.cs)
    command -v dotnet >/dev/null && dotnet format whitespace --include "$file" --no-restore >/dev/null 2>&1 || true
    ;;
  *.py)
    if command -v ruff >/dev/null; then
      ruff format "$file" >/dev/null 2>&1 || true
      ruff check "$file" 2>&1 | head -20 || true
    fi
    ;;
  *.ts|*.vue|*.js|*.tsx|*.jsx)
    if [ -x "$CLAUDE_PROJECT_DIR/frontend/node_modules/.bin/prettier" ]; then
      "$CLAUDE_PROJECT_DIR/frontend/node_modules/.bin/prettier" --write "$file" >/dev/null 2>&1 || true
    fi
    ;;
  *.md)
    # Team convention: hyphens, never em dashes.
    if grep -n $'\xe2\x80\x94' "$file" >/dev/null 2>&1; then
      echo "Em dash found in $file. Use a hyphen or restructure the sentence:"
      grep -n $'\xe2\x80\x94' "$file" | head -5
    fi
    ;;
esac

exit 0
