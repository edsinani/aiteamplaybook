# Extras: tightening the process

Optional. The playbook's enforcement is the pull request: every change is read
by the AI first pass and a human before it merges. On a team of three to six
that is usually enough, because a change to a hook or to the allow list is
visible in the diff and the reviewer asks why.

A team that wants the rule files locked, not just watched, adds the four things
below. Each one runs on the git host or in managed settings, where a local edit
changes nothing.

1. `CODEOWNERS`: copy to `.github/CODEOWNERS`, replace `@lead`, and switch on
   "require review from code owners" in the branch protection rule. No change
   to a rule file merges without the lead.
2. `playbook-guard.yml`: paste the job into `.github/workflows/ci.yml`. It fails
   when a rule file changed in a pull request without the `playbook-change`
   label. Create the label. Required checks are named in branch protection, so
   a check that never reports blocks the merge; deleting a job does not help.
3. Two policy lines. In `docs/review-policy.md`, add to the High tier: "any
   change to the playbook files". In `docs/definition-of-done.md`, add: "a
   change to an approved spec is its own pull request, never in the same one
   as the code that claims to satisfy it".
4. Managed settings (Team and Enterprise plans). Settings deployed by the
   administrator win over `.claude/settings.json`. `allowManagedPermissionRulesOnly`
   makes local removal of a deny rule impossible. Hooks can be set at the
   managed level too.

What this still does not stop: a developer building a change by hand and
opening an ordinary pull request. That is fine. The template still asks how it
was built, the same checks run, and the same reviewer reads it.
