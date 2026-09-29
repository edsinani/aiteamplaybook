# Run the agent with no entitlements

Optional. The rules in `docs/` bound what the agent may run. These seven steps
bound who the agent is, what it can reach and what it can spend, and each one
is a setting that already exists. The full version with checks is at
intelligentrics.com/playbook/entitlements.

1. **A scoped identity.** A fine-grained GitHub token or a GitHub App
   installation for this repository only, contents and pull requests
   permission, stored where the agent runs. No cloud credentials.
2. **Secrets out of reach.** Extend the deny list in `.claude/settings.json`
   to every credential file and every fixture with real records. On Team or
   Enterprise plans, deliver the deny list as managed settings.
3. **Sandbox and egress allowlist on.** Already in `.claude/settings.json`.
   Trim the domain list to the stack. In managed settings, set
   `permissions.disableBypassPermissionsMode` to `disable`.
4. **Off the desktop when the data warrants it.** A dev container with an
   egress firewall, Codespaces, or Claude Code on the web. Never mount
   `~/.ssh` or cloud credential files into it.
5. **A hard spend cap per person**, set in the admin console, with a written
   request path for raising it. The threshold in `docs/governance.md` stays
   as the early signal below the cap.
6. **Telemetry on.** `CLAUDE_CODE_ENABLE_TELEMETRY=1` and the OpenTelemetry
   exporter pointed at the team's collector.
7. **Written down.** Identity, deny list, domains, where sessions run, cap,
   request path and collector, each in `docs/governance.md` next to the
   setting that enforces it.

What this does not stop: a developer running an agent outside all of it. The
pull request template's "how it was built" section, the checks and the
reviewer are what catch that.
