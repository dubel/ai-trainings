# Change request: expose the report API

The team proposes these changes:

- Add public ingress on port 8443 to the report API security group.
- Let the report API role read every object under `s3://shared-exports/*`.
- Store the third-party API token in a Kubernetes Secret created by the deployment pipeline.
- Roll out to production after a successful staging smoke test.

Current evidence:

- `fixtures/ownership.md` lists component owners.
- `fixtures/verification.md` lists available checks.
- No threat model or rollback test is attached.

