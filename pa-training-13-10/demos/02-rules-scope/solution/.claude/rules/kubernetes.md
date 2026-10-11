---
paths:
  - "deploy/**/*.yaml"
  - "deploy/**/*.yml"
---

# Kubernetes rules

- Deployments declare readiness probes.
- Workload image tags are immutable; never use `latest`.
- After manifest edits, run `kubectl apply --dry-run=client -f deploy/`.

