# About this demo

## Quick orientation

This demo separates three independent ways of reducing waste in agentic engineering work:

- **RTK-style compression:** reduce noisy terminal output before it enters model context.
- **Caveman-style communication:** produce a short operational update that preserves decisions and evidence.
- **Ponytail-style implementation:** remove speculative code and keep the patch no larger than the acceptance criteria require.

The three measurements are different. Do not add their percentages or claim that fewer terminal bytes equal the same reduction in total model cost.

## Part A: RTK-style terminal compression

Run:

```bash
node scripts/compare-output.mjs
```

For the supplied fixture, the expected measurements are:

| Output | Lines | Bytes |
|---|---:|---:|
| Raw training log | 26 | 1066 |
| Compact fixture | 4 | 146 |

The compact output is acceptable because it preserves all diagnostic facts needed for the next action:

- one of twelve policy checks failed;
- source is `policy/public-ingress.rego:47`;
- resource is `aws_security_group.report_api`;
- exact problem is `0.0.0.0/0` on TCP 8443;
- summary is eleven passed and one failed.

The fixture is labelled training data. These numbers are not an RTK product benchmark and do not predict total session savings.

## Part B: Caveman-style status

The participant writes no more than seven lines. The expected answer in `expected-incident-update.md` preserves:

1. failed job and time;
2. exact resource and policy violation;
3. policy source location;
4. user or delivery impact;
5. what the saved log proves;
6. what remains unverified;
7. next owner and action.

Shortness is not the only criterion. Removing the failure time, impact, uncertainty, or next owner would make the update smaller but worse.

## Part C: Ponytail-style review

The proposed diff replaces one unsafe CIDR with:

- a new remote module dependency;
- three guessed enterprise CIDRs;
- a fallback policy;
- normalization logic;
- a new local abstraction.

None of those choices is justified by the fixture. The smallest safe review conclusion is:

> Do not merge the proposed abstraction. Obtain the approved ingress CIDRs from the report API or Cloud Security owner, then replace `0.0.0.0/0` directly with that reviewed input or an already established repository variable. Keep the policy check as the proof.

If no approved CIDR exists, stop and request the missing decision. Inventing “private-looking” ranges is not a safe implementation.

## Reasoning path participants should follow

### For terminal output

1. Identify the next engineering decision.
2. Preserve the minimum evidence needed for that decision.
3. Measure lines and bytes before and after.
4. Check recoverability: can the full log still be retrieved when the compact signal is insufficient?
5. Record terminal reduction separately from overall prompt, reasoning, and response cost.

### For status communication

1. Lead with the failed component and impact.
2. Include exact error and first failing time.
3. Separate verified facts from unknown state.
4. End with an owner or next check.
5. Remove narrative only after the operational facts survive.

### For implementation scope

1. Restate the failing acceptance criterion.
2. Mark every changed line that directly satisfies it.
3. Challenge new dependencies, abstractions, defaults, and cleanup.
4. Stop when a required business value is missing instead of inventing it.
5. Verify the smallest patch with the original failing check and relevant regressions.

## Suggested live flow

1. Show the noisy log for ten seconds and ask the room to name the actual failure.
2. Run the comparison script and verify the preserved signal.
3. Give participants two minutes to write a seven-line update without showing the expected answer.
4. Compare updates by missing facts, not prose elegance.
5. Review the proposed diff and circle every decision that lacks an owner or requirement.
6. Ask for the smallest acceptable patch. The answer may be “blocked until approved CIDRs are supplied.”
7. Finish by mapping each part to its own metric: bytes, response tokens/facts, and changed lines/criteria.

## Expected exercise result

Participants should produce:

- a measured raw-versus-compact terminal comparison with the failure signal intact;
- a seven-line incident update containing all seven operational facts;
- a review rejecting speculative dependency and fallback additions;
- a minimal implementation proposal tied to an approved CIDR source and the failing policy check.

They should be able to explain that optimization is valid only when required information and correctness remain intact.

## Common wrong turns

- Calling the fixture a live RTK benchmark.
- Reporting an 86% byte reduction as an 86% total token or cost reduction.
- Compressing away the policy source, resource, or exact port.
- Writing a short status with no impact, uncertainty, or owner.
- Approving guessed RFC1918 ranges because they look safer than public ingress.
- Keeping the remote module because it might be useful later.
- Optimizing line count while omitting a required edge case.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| Node.js is unavailable | The local comparison script cannot run | Count the visible 26 and 4 lines manually and compare fixture file sizes with standard local tools if available. |
| Measured bytes differ slightly | Line endings or file edits changed | Focus on the method and preserved signal; report the actual local values. |
| Participants cannot stay under seven lines | Facts are mixed with narrative | Use one line for each required fact in the listed order. |
| The group wants to pick example CIDRs | The business input is missing | Treat the task as blocked and name the owner who must provide the approved value. |
| The smallest patch still fails policy | The approved input or existing variable is wrong | Use the policy failure as evidence and iterate narrowly; do not restore public ingress. |

**Trainer fallback:** display `noisy-ci.log`, `compact-output.txt`, `expected-incident-update.md`, and `proposed-fix.diff` side by side. Walk through preserved signal, concise status, and unsupported lines without executing any command.

## Transfer to a real project

Choose one noisy command, one repeated status format, and one recent over-scoped patch. Establish separate baselines for output bytes, communication completeness, and changed lines. Add a recovery path for compressed diagnostics, a required-facts checklist for updates, and a review question for every new abstraction or dependency. Optimize each layer independently and keep correctness as the non-negotiable constraint.
