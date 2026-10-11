# Repository instructions

- Terraform modules live under `infra/`; Kubernetes manifests live under `deploy/`.
- Run `npm test` before reporting completion.
- Never run `terraform apply`; the delivery pipeline owns apply.
- Do not claim a check passed unless its command ran successfully in the current session.

Sensitive-file access is enforced in `.claude/settings.json` and a `PreToolUse` hook, not by this file.

