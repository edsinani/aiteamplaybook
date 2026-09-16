---
name: review
description: Pre-PR self review. Runs the reviewer agent with fresh context on the current branch, then drafts the PR description from the template with the verification evidence filled in. Use when a task's implementation is complete and the check passes.
---

# /review

1. Confirm the check passes: run the project check and show the output. If it fails, stop; this skill is for finished work.
2. Show `git diff --stat main...HEAD`. Count changed lines excluding generated files. If over 400, propose the split and stop.
3. Run the `reviewer` agent. Show its findings.
4. For each Important finding: fix it, or write the one-line reason it stands. Do not silently ignore any.
5. Draft the PR description from `.github/PULL_REQUEST_TEMPLATE.md`. Every line filled. The Verification section carries actual evidence: the test names that cover each cited requirement, the command and its output, or the screenshot path.
6. Check the docs line of the definition of done: did `AGENTS.md`, `docs/design.md` or the feature `design.md` status log need a change? If yes and it is not in the diff, add it.
7. Give the developer the exact git commands to commit and push, and the `gh pr create` command with the drafted body. Do not run them.
