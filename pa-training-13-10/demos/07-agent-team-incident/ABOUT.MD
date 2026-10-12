# About this demo

## Quick orientation

This demo uses an experimental agent team for a cross-layer incident. Unlike ordinary subagents that independently return results to a lead, teammates are expected to exchange questions when evidence from Kubernetes, infrastructure, and observability intersects.

The exercise is successful when the team reconstructs one timestamped causal chain without contacting a real cluster or cloud account. Production mutation is explicitly out of scope.

## Evidence timeline

The fixtures support the following chronology:

| Time | Evidence | Interpretation |
|---|---|---|
| 10:02:14 | Terraform apply removes report API egress to database SG on TCP 5432 | Suspected infrastructure cause begins |
| 10:03:42 | New report API rollout starts | New pods begin depending on the changed network path |
| 10:04 | Database success falls to 61.20% | Cross-layer degradation appears |
| 10:05 | Database success reaches 0%; app logs show timeout to `db.internal:5432` | Strong evidence for lost database connectivity |
| 10:05-10:06 | Readiness probes return HTTP 503 | Kubernetes symptom, not the root cause by itself |
| 10:07 | One replica available, three updated; 503 rate is 66.7% | Partial service degradation during rollout |
| 10:09 | Operator pauses rollout | Human containment action |
| 10:10 | Legacy replica returns HTTP 200 | Older replica remains healthy |

## Reasoning path participants should follow

1. Build a shared timeline before choosing a root cause.
2. Label each observation as symptom, contributing factor, probable root cause, or missing evidence.
3. Ask cross-layer questions. Kubernetes should ask infrastructure what changed before readiness failed; infrastructure should ask observability whether database connectivity changed at the same time.
4. Distinguish correlation from proof. The timing and exact port make the removed egress rule the probable root cause, but the fixture is not a live packet trace or effective-policy dump.
5. Keep hypotheses falsifiable. A safe next check should be able to disprove the conclusion.
6. Preserve containment. The rollout is already paused; do not propose an unreviewed production mutation from the training session.
7. Use one integration owner. Only the lead writes the incident synthesis, preventing three incompatible summaries.

## Expected incident classification

- **Symptoms:** readiness HTTP 503s, zero database connection success, elevated readiness latency, and partial availability during rollout.
- **Contributing factor:** the plan review had no database connectivity test, and the change ticket framed egress as HTTPS-only without accounting for PostgreSQL on TCP 5432.
- **Probable root cause:** the Terraform change removed report API egress to the database security group on TCP 5432 immediately before connectivity and readiness failures.
- **Containment:** an operator paused the rollout; a legacy replica remained healthy.
- **Missing evidence:** effective security-group state, database-side rules, DNS resolution, route and network ACL state, connection telemetry, exact old-replica network path, and approved remediation decision.
- **Safe next checks:** read-only inspection of effective rules and recent changes, comparison of old and new pod connectivity configuration, and retrieval of relevant network-flow or connection logs if already available.

## Expected teammate interaction

At least one question must cross layers. Examples:

- Kubernetes to infrastructure: “Was TCP 5432 egress removed before the first readiness failure at 10:05?”
- Infrastructure to observability: “Did database connection success drop immediately after the 10:02 apply?”
- Observability to Kubernetes: “Do legacy and updated replicas show different readiness or connectivity behavior?”

If teammates only write isolated reports and never exchange evidence, the scenario could have used subagents. The interaction requirement is what justifies the agent-team mechanism.

## Suggested live flow

1. Confirm the feature is supported and enable it only in the disposable training environment.
2. Open `team-prompt.md` and verify file ownership and the no-mutation boundary.
3. Start the team and observe the shared task list.
4. Check that each teammate reads only its evidence file.
5. Ask the lead to require one cross-layer question before synthesis.
6. Review `incident-summary.md` against the timeline and categories above.
7. Stop if the team proposes real production access or multiple teammates edit the same file.

## Expected exercise result

The lead produces a single incident summary with timestamped citations, a probable rather than absolute root-cause statement, missing evidence, and read-only next checks. Teammates exchange at least one cross-layer message. No external system is contacted, no remediation is executed, and only the lead writes the summary.

The learning outcome is a decision rule: use an agent team when independent workers need peer-to-peer coordination or shared task state. Use ordinary subagents when workers can report independently to a lead. Use one session for serial work or a tightly shared evolving context.

## Common wrong turns

- Declaring the readiness probe itself the root cause.
- Ignoring timestamps and selecting the most dramatic log line.
- Calling the removed rule definitive proof without effective-state evidence.
- Asking all teammates to read all evidence, eliminating ownership boundaries.
- Letting teammates edit `incident-summary.md` concurrently.
- Proposing `terraform apply`, security-group edits, or cluster changes from the demo.
- Using an agent team only to make three independent summaries, which adds coordination cost without benefit.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| Agent teams are unavailable | The feature is experimental, disabled, or unsupported | Use three subagents or three fresh conversations and manually relay one cross-layer question between them. |
| Teammates do not message one another | The prompt was treated as independent fan-out | Ask the lead to hold synthesis until every teammate asks or answers one cross-layer question. |
| Multiple summaries appear | File ownership was not enforced | Stop edits and designate the lead as the sole writer. Use teammate output as evidence only. |
| The conclusion is too certain | Missing evidence was omitted | Change “root cause” to “probable root cause” and list checks that could falsify it. |
| The team requests production access | The task boundary is unclear | Decline access and use only saved fixtures. Read-only next checks may be listed, not executed. |

**Trainer fallback:** assign the three evidence files to three people. Each writes a hypothesis and one question to another person. The trainer merges their answers into the timeline. This preserves the collaboration lesson without the experimental feature.

## Transfer to a real project

Choose incidents with genuinely separate evidence domains and a need for cross-domain exchange. Define a lead, task ownership, shared evidence format, communication rule, tool boundary, and single summary owner. Begin with read-only investigations. Evaluate whether peer coordination improved the causal model enough to justify higher token and orchestration cost.
