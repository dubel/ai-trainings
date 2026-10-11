# Terraform change risk policy

- `BLOCKED`: deletion of a production database, KMS key, audit-log sink, or state backend.
- `HIGH`: any resource replacement in production, public network exposure, IAM privilege expansion, or more than five destroys.
- `MEDIUM`: non-production replacement, security-group rule change without public exposure, or one to five non-critical destroys.
- `LOW`: additive change with no privilege, network, persistence, or destructive effect.

The reviewer does not approve an apply. A human owns environment selection, exceptions, and deployment authorization.

