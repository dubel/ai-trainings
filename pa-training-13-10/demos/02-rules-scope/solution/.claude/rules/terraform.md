---
paths:
  - "infra/**/*.tf"
---

# Terraform rules

- Expose stable module outputs instead of reading sibling state files.
- After Terraform edits, run `terraform fmt -check -recursive infra`.
- Produce a plan for review; never apply from an agent session.

