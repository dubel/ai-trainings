# About this demo

## Quick orientation

This demo separates three ideas that are often confused: an instruction asking the model not to read secrets, a Claude Code control that blocks normal tool requests, and a system boundary that makes the secret unavailable to every process. The sample combines permission deny rules, a `PreToolUse` hook, and tests for representative paths.

The intended conclusion is deliberately conservative: hooks improve deterministic handling of known tool requests, but the strongest guarantee is to keep sensitive values outside the agent's filesystem and environment.

## Control layers at a glance

1. `.claude/settings.json` denies built-in read and edit requests for `.env`, `secrets/`, `.pem`, and `.key` paths.
2. The `PreToolUse` hook runs for `Read`, `Edit`, `Write`, `Bash`, and `PowerShell`.
3. `block-sensitive-read.mjs` normalizes Windows separators, exempts `.env.example`, and blocks recognizable sensitive paths or commands with exit code `2`.
4. `test-hook.mjs` sends saved JSON requests to the hook and verifies which requests are blocked.
5. A container, VM, mount policy, separate identity, or short-lived credential limits what remains possible if a command bypasses the parser.

## Reasoning path participants should follow

1. State the asset and threat precisely. “Never read secrets” is not a path pattern; it is a system requirement.
2. Remove unnecessary secrets first. A value absent from the workspace cannot be exposed by a file-reading command in that workspace.
3. Use built-in deny rules for common direct tool operations.
4. Add a hook for consistent feedback and additional tool inputs such as shell commands.
5. Normalize inputs before matching. Windows and Unix paths should receive the same decision.
6. Define safe exceptions explicitly. `.env.example` is training configuration, not a secret file in this sample.
7. Test allow and deny cases. A guard with only positive blocking tests may accidentally block ordinary source files.
8. Describe residual risk honestly. String and command parsing cannot recognize every encoding, indirection, archive, generated path, or alternative executable.
9. Put the hard guarantee in the OS or runtime boundary: no mount, redacted fixture, scoped identity, isolated container, or secret broker.

## Expected test result

Run:

```bash
node scripts/test-hook.mjs
```

The expected output is:

```text
Sensitive-file hook: 7 cases passed.
```

The cases prove that normal source and `.env.example` are allowed, while root `.env`, nested `.env.production`, a Windows `secrets` path, `cat .env`, and a PowerShell private-key read are blocked.

The current fixture already contains the requested path variants, so the exercise can be run as a review. For a hands-on editing version, temporarily remove one or two table rows before the session and ask participants to restore them, or add new variants such as `services/api/.env.local` and `certs/client.pem`.

## Suggested live flow

1. Ask whether `CLAUDE.md: do not read .env` is a deterministic control. The expected answer is no.
2. Show the deny patterns in settings and name which built-in operations they address.
3. Show the hook matcher and trace one direct `Read` request through normalization and regex checks.
4. Trace one shell command and one Windows path.
5. Run the tests and show both allowed and blocked cases.
6. Ask the group for a bypass that a string parser might miss. Do not turn this into an obfuscation contest; use it to motivate system isolation.
7. Finish by naming the production boundary: secrets are not mounted, credentials are scoped and short-lived, and production mutation remains behind approval.

## Expected exercise result

Participants should be able to draw the following hierarchy:

```text
instruction -> influences model behavior
deny rule   -> blocks supported direct tool paths
hook        -> evaluates matching tool requests before execution
sandbox/OS  -> limits every process regardless of prompt or parser
```

A good implementation result adds representative test cases without weakening `.env.example`, keeps the hook fail-closed on invalid JSON, and documents that exit code `2` means blocked. A good architecture result identifies at least one boundary that removes the secret from the agent's accessible workspace.

## Common wrong turns

- Calling a prose rule a security control.
- Calling the hook a complete sandbox.
- Testing only `.env` at the repository root.
- Forgetting Windows separators or shell command inputs.
- Blocking `.env.example` and breaking normal development context.
- Logging the sensitive value in the hook's error message.
- Giving the training agent real production secrets to prove the guard works.
- Assuming a passing fixture proves resistance to every command encoding or process.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| The test script is unavailable | Node.js is missing | Walk through the JSON cases and expected exit statuses manually. Do not test with real secrets. |
| A safe example is blocked | Exception handling occurs after the sensitive match or the path differs | Normalize first, replace the exact approved example, and add an allow regression case. |
| A Windows path passes unexpectedly | Backslashes were not normalized | Confirm `.replaceAll("\\", "/")` runs before matching and keep the Windows regression test. |
| Claude Code ignores the hook | Settings discovery, environment variable, or product version differs | Run `test-hook.mjs` directly to validate the script, then verify current hook configuration separately. |
| The group asks for a perfect regex | The requirement exceeds parser guarantees | Stop expanding patterns and move the guarantee to filesystem, identity, container, or VM isolation. |

**Trainer fallback:** execute the hook directly with the saved test harness and draw the four-layer hierarchy. No actual `.env`, key, cloud account, or secret value is needed.

## Transfer to a real project

Inventory paths, environment variables, credential helpers, cloud metadata, shell history, generated artifacts, and diagnostic bundles. Remove secrets from agent workspaces by default. Add organization-level controls and repository hooks for predictable feedback, then test allow and deny cases in CI. Review logs to ensure the guard itself never prints the protected value.
