# Expected concise update

- `infra-validate` failed on policy check 12/12 at 10:03:20.
- `aws_security_group.report_api` exposes TCP 8443 to `0.0.0.0/0`.
- Policy evidence: `policy/public-ingress.rego:47`.
- Impact: the change cannot pass the delivery gate; no deployment evidence is present.
- Verified: formatting, Terraform validation, and 11 policy checks passed in the saved log.
- Unverified: live cloud state and whether the rule has already been applied elsewhere.
- Next: the report API owner must supply the approved ingress CIDRs and rerun the policy check.

