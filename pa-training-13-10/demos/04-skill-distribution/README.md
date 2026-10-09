# Exercise 04 — Central skill distribution

## Goal

Inspect a minimal Claude Code plugin and a private marketplace that a team can host in GitHub.

## Layout

```text
marketplace/
├── .claude-plugin/marketplace.json
└── plugins/cloud-ops/
    ├── .claude-plugin/plugin.json
    └── skills/k8s-preflight/SKILL.md
```

## Exercise

1. Open `marketplace/.claude-plugin/marketplace.json`.
2. Resolve the relative plugin source path.
3. Confirm that the marketplace entry name matches the plugin manifest name.
4. Inspect the skill command name: `/cloud-ops:k8s-preflight`.
5. Decide who owns releases, reviews third-party code, and can roll back a bad version.

If Claude Code is installed, validate locally without installing anything:

```bash
claude plugin validate ./marketplace/plugins/cloud-ops
claude plugin validate ./marketplace
```

## Distribution choices

- One repository: commit `.claude/skills/<name>/SKILL.md`.
- Several repositories: package skills, agents, hooks, and MCP config as a plugin.
- Team catalog: host `.claude-plugin/marketplace.json` in a private GitHub repository.
- Organization control: require a marketplace or deploy managed settings.
- Personal experiment: use `~/.claude/skills/`, then promote it after review.

## Use it in your project

Start with a project skill and an owner. Promote it to a plugin only after a second repository needs the same behavior. Add semantic versioning, a changelog, evals, trust review, and rollback guidance before broad distribution.

Official flow after the repository is hosted:

```text
claude plugin marketplace add <owner>/<repo>
claude plugin install cloud-ops@team-cloud-tools
```

