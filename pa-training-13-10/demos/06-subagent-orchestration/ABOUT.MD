# About this demo

## Quick orientation

This demo uses three custom read-only subagents to inspect one cloud change from different perspectives. The main agent keeps the integration decision; workers absorb narrow file context and return evidence in the same schema.

The lesson is not “three agents are better than one.” Delegation is useful only when work is independent, bounded, evidence-heavy, and cheaper to summarize than to keep in the main conversation.

## Scenario at a glance

The proposed report API change introduces four decisions:

- public ingress on TCP 8443;
- read access to every object under `s3://shared-exports/*`;
- a third-party token stored as a pipeline-created Kubernetes Secret;
- production rollout after a staging `/health` smoke test.

The available evidence identifies component owners and several validation commands, but it has no threat model, IAM access simulation, or tested production rollback.

## Worker responsibilities

| Worker | Primary question | Files it should need |
|---|---|---|
| `inventory-reviewer` | What resources, systems, and owners are involved? | `change-request.md`, `ownership.md` |
| `security-reviewer` | Which IAM, network, and credential risks need decisions? | `change-request.md`, relevant ownership facts |
| `verification-reviewer` | Which claims have checks, and what evidence is missing? | `change-request.md`, `verification.md` |

All workers return `Finding`, `Evidence`, `Confidence`, `Missing evidence`, and `Next check`. They do not edit files, execute shell commands, inspect external systems, or read secret values.

## Reasoning path participants should follow

1. Keep the original question in the main context: is this change ready, and what must happen next?
2. Split by independent evidence domain, not by arbitrary file count.
3. Give each worker only the files and tools required for its question.
4. Require a shared return schema so results can be compared and merged mechanically.
5. Run workers in parallel because no result depends on another worker's output.
6. Preserve uncertainty. Missing threat model, IAM simulation, and rollback test are findings, not details to invent.
7. Bring compact evidence back to the main agent.
8. Resolve cross-domain contradictions centrally. No worker has enough context to own the final readiness decision.
9. Keep shared edits with one owner. This exercise is read-only, so concurrent file conflicts are avoided entirely.

## Expected worker findings

### Inventory reviewer

The change touches the report API security group, the report API IAM role, the shared exports bucket, a Kubernetes Secret, and the deployment pipeline. Owners include Analytics Platform, Data Platform, Cloud Security, and Developer Experience. The reviewer should flag that several owners must participate; it should not infer their approval.

### Security reviewer

The public 8443 ingress needs an explicit source and Cloud Security decision. `shared-exports/*` may be broader than the report API needs and has no IAM simulation evidence. A pipeline-created Kubernetes Secret avoids plaintext in the repository but still needs a source, access, rotation, namespace, and log-exposure model. “Stored in a Secret” is not the same as “safe.”

### Verification reviewer

Available checks include Terraform validation, a saved plan, one ingress policy, and a staging health smoke test. They do not prove least-privilege S3 access, token handling, production behavior, or rollback readiness. The policy rejects public ingress only on administrative ports, so it may not catch public TCP 8443. The reviewer must not claim any command passed merely because its name appears in the fixture.

## Expected synthesis

The final decision should be “not ready for production evidence” or an equivalent qualified hold, not an automatic rejection of every design choice. A useful table looks like this:

| Area | Evidence | Decision / gap | Safe next check |
|---|---|---|---|
| Ownership | Four named platform owners | Cross-team approvals are not attached | Confirm owner decisions in the change record |
| Network | Public 8443 requested; policy scope is limited | Source CIDRs and threat model missing | Review plan and policy result; obtain Cloud Security decision |
| IAM | Read access to all shared exports | Least privilege not demonstrated | Run a read-only IAM simulation or policy analysis |
| Secret | Pipeline creates a Kubernetes Secret | Rotation and access path are unspecified | Review secret source, RBAC, rotation, and redaction design |
| Rollout | Staging `/health` smoke test exists | No tested production rollback | Define and test rollback in a safe environment |

## Suggested live flow

1. Read the change request in the main session and write the final synthesis question.
2. Show the three agent definitions and ask why each tool list is read-only.
3. Assign non-overlapping files and launch the three investigations in parallel.
4. While they run, ask the audience what must remain in the main context.
5. Normalize returned findings into one decision table.
6. Highlight duplicated work, unsupported claims, and disagreements.
7. Ask whether a single worker would have been cheaper. If yes, delegation was unnecessary for this instance.

## Expected exercise result

The participant should produce three bounded reports and one integrated decision table. Every major statement cites a fixture field or is labelled missing evidence. No file is edited and no external command is called.

They should also be able to explain what stayed out of the main context: detailed topology inventory, repeated risk scanning, and check enumeration. The main context retained the user request, cross-domain trade-offs, contradiction resolution, and final recommendation.

## Common wrong turns

- Giving every worker every file, which duplicates cost and context.
- Asking all workers the same broad question.
- Letting workers return incompatible prose instead of a shared schema.
- Treating a listed command as a successful command result.
- Delegating the final decision and then combining three incompatible approvals.
- Allowing several workers to edit the same summary file.
- Using subagents for a short, sequential task whose handoff costs exceed the work.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| Custom agents are not discovered | Product version or project discovery differs | Attach the three agent files manually and run three separate read-only prompts. |
| Parallel execution is unavailable | Environment or account limitation | Run the reviews sequentially in fresh contexts, preserving the same file boundaries and schema. |
| Workers duplicate findings | Their questions or files overlap too much | Tighten ownership and state what each worker must not investigate. |
| A worker claims a check passed | It confused available checks with evidence | Reject the claim and require an exact supplied result or label it unverified. |
| Synthesis is just concatenation | The main agent did not resolve decisions | Build the decision table manually and add a single readiness recommendation. |

**Trainer fallback:** divide the room into three groups, give each group only its printed fixture, and have them return the five-field schema. The trainer plays the main agent and integrates the table.

## Transfer to a real project

Use subagents for high-volume inventory, log review, dependency analysis, or specialized security and verification work. Define a crisp question, minimal context, narrow tools, one return schema, and one integration owner. Measure whether delegation reduced main-context load and elapsed time; do not keep it simply because the demo looked sophisticated.
