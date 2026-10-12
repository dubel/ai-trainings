# About this demo

## Quick orientation

This demo turns one overloaded `CLAUDE.md` into guidance with deliberate scope. It teaches a placement decision: information needed for almost every task belongs at the repository root, file-type exceptions belong in path-scoped rules, reusable procedures belong in skills, and hard invariants belong in hooks, permissions, CI, or the operating environment.

The exercise is complete when the same useful knowledge is available with less irrelevant context and no false security claims.

## Starting state at a glance

`starter/CLAUDE.md` mixes six different categories:

- repository topology;
- a repository-wide verification command;
- vague quality preferences;
- formatting already enforced by CI;
- Terraform-specific behavior;
- Kubernetes-specific behavior;
- a sensitive-file instruction that is not an enforcement boundary.

The file is not wrong because it is long. It is wrong because every task pays for instructions that are often irrelevant, and because prose such as “Do not read `.env`” can be mistaken for a deterministic control.

## Reasoning path participants should follow

Classify every line before moving it:

1. **Is it needed for nearly every task?** Keep it in root `CLAUDE.md`.
2. **Does it apply only to a path or file type?** Put it in `.claude/rules/*.md` with explicit `paths` frontmatter.
3. **Is it a multi-step method invoked for a type of task?** It is a skill candidate, not a permanent rule.
4. **Can a formatter, linter, policy engine, hook, permission, or CI job enforce it?** Keep the hard control there; the rule may explain the control but must not pretend to enforce it.
5. **Is it generic encouragement?** Delete it. “Think carefully” and “do an excellent job” do not provide repository-specific evidence.
6. **Would a new engineer learn something surprising and stable about the repository?** Preserve that fact at the narrowest useful scope.

## Expected classification

| Starter instruction | Expected decision | Why |
|---|---|---|
| Terraform lives in `infra/`; Kubernetes lives in `deploy/` | Keep at root | Repository topology is broadly useful |
| Run `npm test` before completion | Keep at root | Repository-wide finish condition |
| Think carefully and do an excellent job | Delete | Non-testable generic preference |
| Use two spaces in YAML | Delete from agent guidance | Formatter already enforces it |
| Never run `terraform apply` | Keep at root and repeat in Terraform rule if useful | High-impact workflow boundary |
| Stable Terraform outputs and `terraform fmt` | Terraform path rule | Relevant only to `infra/**/*.tf` |
| Readiness probes, immutable tags, dry-run | Kubernetes path rule | Relevant only to deployment YAML |
| Explain every changed line | Delete | Expensive generic behavior without a repository need |
| Do not read `.env` | Replace with an enforcement reference | Prose is not a security boundary |

## Suggested live flow

1. Copy `starter/CLAUDE.md` to a scratch location or edit a disposable copy.
2. Ask participants to label every line `root`, `path rule`, `skill`, `enforcement`, or `delete`.
3. Build a short root file without looking at the solution.
4. Create `terraform.md` with `infra/**/*.tf` paths and `kubernetes.md` with deployment YAML paths.
5. Compare with `solution/CLAUDE.md` and `solution/.claude/rules/`.
6. Discuss differences as scope decisions, not as a word-for-word answer key.

## Expected exercise result

The root file contains repository topology, the shared test command, the prohibition on agent-owned `terraform apply`, and the rule that evidence must come from a command actually run in the current session.

The Terraform rule contains stable module outputs, `terraform fmt -check -recursive infra`, plan-for-review behavior, and no apply. The Kubernetes rule contains readiness probes, immutable image tags, and client-side dry-run verification. Sensitive-file access is described as enforced elsewhere rather than guaranteed by prose.

The participant should be able to explain why each instruction lives where it does. That explanation is more important than matching the solution text exactly.

## Common wrong turns

- Moving all instructions into many tiny rule files. Excessive fragmentation makes ownership and conflicts harder to understand.
- Treating path scoping as a security control. It controls context selection, not OS-level access.
- Duplicating formatter output as prose. The agent spends context on a fact that a deterministic tool already proves.
- Putting a long release checklist in a rule. A reusable, ordered procedure is usually a skill.
- Storing personal preferences in the repository root. Global user preferences should not become a team contract without agreement.
- Ignoring precedence or conflict. Root and nested guidance should agree; a conflict needs an explicit ownership decision.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| Path rules are not loaded | The installed Claude Code version or rule syntax differs | Open the rule files manually and discuss intended scoping; verify current product syntax after the workshop. |
| Participants copy the solution immediately | The exercise feels like document cleanup | Hide `solution/` until every starter line has a category and reason. |
| The group disagrees about root versus local | The invariant's actual scope is unclear | Ask for a counterexample file where the instruction would be irrelevant or harmful. Use the narrowest scope that covers all valid cases. |
| “Never apply” appears only in prose | The team needs stronger enforcement | Name the real boundary: credentials, approval gates, sandboxing, or CI ownership. Keep prose as explanation only. |
| There is no Terraform or Kubernetes tool installed | The exercise is about information architecture | Review the files without executing tool-specific commands. |

**Trainer fallback:** print the starter instructions as cards and sort them into five columns: root, scoped rule, skill, deterministic enforcement, delete. Then reveal the solution tree.

## Transfer to a real project

Collect repeated corrections from reviews and recent agent sessions. For each correction, ask whether it is stable, surprising, path-specific, procedural, or enforceable. Remove instructions that merely repeat visible code or CI. Review the resulting guidance like code: assign ownership, test discovery, and delete stale rules when the repository changes.
