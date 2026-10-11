# Deployment gate requirements

`canDeploy(change)` returns a boolean.

- A destructive infrastructure plan must always be rejected.
- A production change requires at least two approvals.
- A non-production change requires at least one approval.
- The public function name and input shape must remain unchanged.
- Do not add logging, network calls, dependencies, or environment reads.

