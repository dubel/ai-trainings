# About this demo

## Quick orientation

This demo shows how a reviewed project skill can become a shared Claude Code plugin and how a private marketplace can act as the team's catalog. The technical files are deliberately minimal. The important design questions are ownership, trust, versioning, discovery, and rollback.

Do not start with a marketplace because it sounds mature. Start with the smallest delivery unit that matches the number of consumers.

## Layout and name resolution

```text
marketplace/
├── .claude-plugin/marketplace.json       # catalog: team-cloud-tools
└── plugins/cloud-ops/
    ├── .claude-plugin/plugin.json        # plugin: cloud-ops, version 1.0.0
    └── skills/k8s-preflight/SKILL.md      # skill: k8s-preflight
```

The marketplace entry points to `./plugins/cloud-ops`. Its entry name and the plugin manifest name are both `cloud-ops`. The skill name is `k8s-preflight`, so the namespaced command shown in the workshop is:

```text
/cloud-ops:k8s-preflight
```

The marketplace name is `team-cloud-tools`, which is used when selecting the catalog source.

## Reasoning path participants should follow

1. Count consumers. One repository normally needs a project skill, not a distribution platform.
2. Identify the delivery unit. A plugin is useful when multiple repositories need the same reviewed skills, agents, hooks, or MCP configuration.
3. Inspect the trust boundary. Installing a plugin means accepting executable or behavior-changing content from its source and update path.
4. Trace names and paths mechanically. Marketplace source, entry name, plugin manifest name, skill name, and command namespace must agree.
5. Assign lifecycle ownership before installation: author, reviewer, release owner, security reviewer, support contact, and rollback authority.
6. Version releases. Consumers need to know what changed and how to return to a known-good version.
7. Separate experimentation from team policy. Personal skills are useful for discovery but are not a centrally supported contract.

## Choosing a sharing mechanism

| Situation | Recommended starting point | Why |
|---|---|---|
| One repository, one team | `.claude/skills/<name>/SKILL.md` in that repository | Review and version it with the code it serves |
| Several repositories need the same workflow | Plugin in a dedicated or platform-owned repository | One versioned package can contain related skills and agents |
| Teams need discovery and approved sources | Private marketplace repository | Central catalog without copying files into every project |
| Organization must restrict allowed sources | Managed settings or a required marketplace | Governance and consistent distribution |
| One person is exploring an idea | `~/.claude/skills/` | Fast experimentation before team promotion |

Other mechanisms such as Git submodules, package-manager scripts, template repositories, internal CLIs, configuration management, or CI synchronization can copy files. They may be appropriate in existing platforms, but they do not automatically provide Claude's plugin discovery, namespacing, trust review, or rollback semantics. Make the operational contract explicit whichever transport is used.

## Suggested live flow

1. Open `marketplace/.claude-plugin/marketplace.json` and locate the catalog name and plugin source.
2. Resolve `./plugins/cloud-ops` relative to the marketplace file.
3. Open `plugin.json` and verify that the plugin is also named `cloud-ops`.
4. Open the skill and verify its name, manual invocation, read-only tools, and explicit mutation prohibition.
5. Derive `/cloud-ops:k8s-preflight` without copying it from the README.
6. If the installed Claude Code supports validation, run the two validation commands without installing.
7. End with the operational questions: who publishes `1.0.1`, who reviews third-party code, how consumers pin or update, and how a bad release is withdrawn.

## Expected exercise result

Participants should be able to explain the complete path from catalog to executable behavior:

```text
team-cloud-tools marketplace
  -> cloud-ops plugin source
    -> cloud-ops version 1.0.0
      -> k8s-preflight skill
        -> read-only Kubernetes evidence and human decision
```

They should also produce a delivery decision for their team. A good answer names the number of repositories, owner, review gate, versioning rule, rollout group, and rollback method. “Put it on GitHub” is transport, not a complete sharing strategy.

## Common wrong turns

- Publishing the first experimental skill organization-wide.
- Copying skill folders between repositories with no source of truth.
- Allowing marketplace and plugin names to drift.
- Installing before reviewing the manifest, skill tools, hooks, and update source.
- Assuming “private GitHub” alone defines who may release or roll back.
- Updating every consumer at once without a canary group or pinning strategy.
- Treating a marketplace as a quality guarantee. It is a catalog; governance still belongs to the organization.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| `claude plugin validate` is unavailable | Claude Code is missing or the installed version uses a different command | Perform static validation: resolve paths, compare names, parse JSON, and inspect the skill frontmatter. |
| Validation reports a source error | Relative path is resolved from the wrong directory | Start at `marketplace/.claude-plugin/marketplace.json` and resolve `./plugins/cloud-ops` from there. |
| The command is not namespaced as expected | Plugin or skill name differs | Compare marketplace entry, `plugin.json`, and `SKILL.md`; do not guess the command. |
| GitHub hosting is unavailable during training | Network or authentication issue | Keep the demo local. Hosting and installation are not required to teach packaging and governance. |
| The group cannot name a rollback path | Release ownership was not designed | Stop before broad distribution and define pinning, known-good version, and withdrawal communication. |

**Trainer fallback:** draw the four-level tree on a whiteboard and ask participants to derive the command name and release responsibilities. The lesson does not require installing a plugin.

## Transfer to a real project

Select one project skill with proven use and a second repository that needs it. Create a versioned plugin, add evals and a changelog, nominate owners, and test it with a small consumer group. Add the private marketplace only when a catalog solves a real discovery or governance problem. Document how to verify the source, pin versions, and roll back before announcing it broadly.
