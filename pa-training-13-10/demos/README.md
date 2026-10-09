# Workshop exercises

Each exercise has a short sample task plus a transfer section for applying the pattern to a real repository.

| Exercise | Topic | Main artifact |
|---|---|---|
| [01](01-prompt-contract/README.md) | Effective prompts | Goal, Context, Boundaries, Evidence contract |
| [02](02-rules-scope/README.md) | Global and local guidance | Root `CLAUDE.md` plus path-scoped rules |
| [03](03-skill-lifecycle/README.md) | Creating and maintaining skills | Terraform plan-review skill with trigger evals |
| [04](04-skill-distribution/README.md) | Central skill distribution | Claude plugin and private marketplace example |
| [05](05-sensitive-file-guard/README.md) | Deterministic sensitive-file boundary | Deny rules plus `PreToolUse` hook |
| [06](06-subagent-orchestration/README.md) | Subagent orchestration and context splitting | Three read-only custom agents |
| [07](07-agent-team-incident/README.md) | Agent teams | Parallel incident hypotheses with shared tasks |
| [08](08-goal-loop/README.md) | Goals and loops | Failing completion condition plus polling fixture |
| [09](09-model-routing/README.md) | Jev, Needle 3, and Claude | Model-routing worksheet |
| [10](10-waste-levers/README.md) | RTK, Caveman, and Ponytail | Noisy log, concise update, minimal-change review |

## Exercise convention

- `starter` or source files are safe to change.
- `solution` and `expected` folders are for comparison after the exercise.
- Commands use local fixtures and do not contact cloud providers.
- A passing test proves only the sample behavior. It does not approve a production deployment.

