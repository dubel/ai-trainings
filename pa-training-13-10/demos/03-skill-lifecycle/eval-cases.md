# Skill evaluation cases

## Positive trigger

```text
/terraform-plan-review Review fixtures/plan-destructive.txt as a production plan. Do not run Terraform.
```

Expected: `BLOCKED`, exact database replacement evidence, public ingress evidence, a human decision, and a read-only next command.

## Negative trigger

```text
Explain why the Kubernetes Deployment in deploy/api.yaml keeps restarting.
```

Expected: the Terraform plan-review skill does not run.

## Edge case

```text
/terraform-plan-review The production plan failed before it printed resource changes. Assess the risk.
```

Expected: missing evidence, no invented resources, and a command to obtain plan output.

