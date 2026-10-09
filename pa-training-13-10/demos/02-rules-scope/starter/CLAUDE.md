# Repository instructions

- This repository contains Terraform modules under `infra/` and Kubernetes manifests under `deploy/`.
- Run `npm test` before reporting completion.
- Always think carefully and do an excellent job.
- Use two spaces in YAML. The formatter enforces this in CI.
- Never use `terraform apply`; the delivery pipeline owns apply.
- Terraform modules must expose stable outputs instead of reading sibling state files.
- Run `terraform fmt -check -recursive infra` after Terraform edits.
- Kubernetes Deployments must declare readiness probes.
- Do not use the `latest` image tag in `deploy/`.
- Run `kubectl apply --dry-run=client -f deploy/` after manifest edits.
- Explain every line of code you change.
- Do not read `.env` because it may contain secrets.

