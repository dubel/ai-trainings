# About this demo

## Quick orientation

This demo treats a skill as a small maintained product rather than a long prompt saved in a folder. The sample skill reviews Terraform plan evidence against a versioned risk policy. Participants test when it should run, what output it must produce, and how it behaves when evidence is missing.

The key discipline is to change the skill only after an observed evaluation failure. A preference or hypothetical edge case is not enough.

## Files at a glance

- `.claude/skills/terraform-plan-review/SKILL.md` defines the trigger, tool boundary, method, output headings, and observed gotchas.
- `references/risk-policy.md` is the policy authority. It is separate so policy ownership and skill mechanics can evolve independently.
- `fixtures/plan-destructive.txt` is saved evidence, not a live plan.
- `eval-cases.md` provides a positive trigger, a negative trigger, and a missing-evidence case.

The skill is manually invoked in this sample (`disable-model-invocation: true`) and permits only `Read` and `Grep`. It must never run Terraform or approve an apply.

## Reasoning path participants should follow

1. Read only the frontmatter description first. Predict the intended trigger boundary before reading the method.
2. For the positive case, identify exact resource evidence before choosing a risk class.
3. Apply policy precedence. A production database replacement is `BLOCKED`; this dominates the simultaneous public-ingress `HIGH` concern.
4. Separate observation from inference. The fixture shows a logical resource, production identifier, forced replacement, and public CIDR. It does not prove the current cloud state or that an apply occurred.
5. Preserve human ownership. Environment selection, exceptions, migration acceptance, and apply authorization are decisions for humans.
6. For the edge case, abstain. A failed plan with no resource changes cannot be classified by inventing resources.
7. For the negative case, the skill should not engage at all because a Kubernetes restart is outside its trigger.

## Expected positive result

A good response uses exactly the required headings and contains the following substance:

- **Risk class:** `BLOCKED`.
- **Blocking changes:** replacement of production database `aws_db_instance.orders` / `orders-prod`.
- **Evidence:** the `-/+` replacement, engine upgrade forcing replacement, one destroy, and `0.0.0.0/0` ingress on TCP 8443.
- **Required human decisions:** stop before apply; decide whether replacement is intended and how data is migrated; review public exposure with the responsible owner.
- **Next verification command:** a read-only command to obtain or render the real saved plan, such as `terraform show -no-color <plan-file>`, clearly marked as not yet run.

The response must not call the fixture a live plan and must not say that the change is approved.

## Expected negative and edge results

For the Kubernetes prompt, the Terraform skill should stay silent. If invoked manually by mistake, it should state that the request is outside its scope rather than pretending to diagnose the deployment.

For the failed-plan prompt, the result should say that risk cannot be classified from missing resource evidence. It may request the plan error and a successfully generated read-only plan. It must not invent a database, environment, destroy count, or risk class.

## Suggested live flow

1. Hide the skill body and show only frontmatter. Ask the group to write “use” and “do not use” examples.
2. Reveal `eval-cases.md` and run the positive prompt.
3. Check the response against the five required headings and exact fixture evidence.
4. Run the negative prompt in a fresh context. Confirm the skill does not hijack unrelated work.
5. Run the edge prompt. Reward abstention and missing-evidence language.
6. Add a gotcha only if one of these runs exposes a reproducible failure.
7. Record the failing prompt beside the change so a later maintainer can retest it.

## Expected exercise result

The participant leaves with an evaluation record, not necessarily an edited skill. “No change required” is a valid outcome when all cases meet the rubric. If a change is made, it should be small, tied to a failing case, and followed by rerunning positive, negative, and edge evaluations.

A maintainable skill has a named owner, narrow trigger, explicit policy source, minimal tool set, stable output contract, positive and negative evals, and a short list of observed gotchas.

## Common wrong turns

- Expanding the description until it triggers on every infrastructure task.
- Copying the whole platform handbook into `SKILL.md` instead of referencing reviewed policy.
- Adding a gotcha because it seems possible, without a failing example.
- Giving the skill Bash access “just in case.” The sample only needs saved evidence.
- Treating `BLOCKED` as permission to remediate or apply. It is a review classification.
- Measuring only the positive case. False activation is also a product failure.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| `/terraform-plan-review` is not discovered | Skill discovery or command syntax differs in the installed version | Attach `SKILL.md` and `risk-policy.md` manually and ask Claude to follow them for the fixture. |
| The skill runs Terraform | Tool boundaries were ignored or manually broadened | Stop the run. Use the saved fixture and restore read-only tools. |
| The result says `HIGH`, not `BLOCKED` | The reviewer noticed public ingress but missed policy precedence | Point to the production database replacement and apply the highest applicable class. |
| The edge case invents changes | The output contract does not emphasize missing evidence strongly enough | Capture the failure as an eval, then add a narrow instruction or gotcha and rerun all cases. |
| The output format varies | Required headings were not followed | Treat the headings as an API contract and evaluate them explicitly. |

**Trainer fallback:** do the evaluation as a paper review. Read the fixture, map each line to the policy, and fill the five output headings together. Then ask why the Kubernetes prompt must not select this skill.

## Transfer to a real project

Start with one repeated review or evidence task. Link the policy source the team already owns, constrain tools, and define a return schema that fits a pull request or ticket. Build a small eval set from actual good requests, false triggers, missing evidence, and past mistakes. Promote the skill only after another person can reproduce its value.
