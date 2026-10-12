# About this demo

## Quick orientation

This demo compares two ways of asking Claude Code to repair the same deployment policy. The code change is intentionally tiny. The real subject is whether the human keeps ownership of policy decisions and gives the agent an observable finish line.

Run A uses the vague prompt in `prompt-vague.md`. Run B starts from a clean conversation and uses `prompt-contract.md`. Do not judge the prompts by response length or writing style. Compare assumptions, proposed files, invented behavior, and completion evidence.

## Code and policy at a glance

`src/deploy-gate.mjs` currently contains two unsafe decisions:

```js
if (planHasDestroy) return approvals >= 2;
return environment === "production" ? approvals >= 1 : true;
```

This means a destructive plan can pass, production needs only one approval, and non-production needs no approval. `task.md` is the policy authority and requires:

- every destructive plan to be rejected;
- two approvals for production;
- one approval for non-production;
- no change to the public function name or input shape;
- no I/O, logging, dependency, environment read, or unrelated refactor.

The focused test starts red on purpose:

```bash
node --test test/deploy-gate.test.mjs
```

## Reasoning path participants should follow

1. Separate the business rule from the implementation. The question is not “how would I improve this function?” but “what exact policy must this function express?”
2. Identify the authority order. `task.md` defines the policy; the tests are executable examples; the current code is only the faulty implementation.
3. List the immutable interface: exported name `canDeploy` and input fields `environment`, `planHasDestroy`, and `approvals`.
4. Derive the smallest decision tree. A destructive plan exits first with `false`. Otherwise, the approval threshold is two for production and one everywhere else.
5. Reject attractive extras. Input validation, logging, richer return objects, dependencies, and refactoring may be reasonable in another task, but they are outside this contract.
6. Require evidence. A plausible edit is not completion until the focused test command exits successfully and the agent reports the changed file.

The intended implementation can remain this small:

```js
export function canDeploy({ environment, planHasDestroy, approvals }) {
  if (planHasDestroy) return false;
  return environment === "production" ? approvals >= 2 : approvals >= 1;
}
```

## Suggested live flow

1. Run the focused test and show that the fixture is intentionally failing.
2. Open a clean Claude Code session and paste `prompt-vague.md`.
3. Stop before editing. Record the plan, questions, files, assumptions, and any invented behavior.
4. Open another clean session and paste `prompt-contract.md`.
5. Again inspect the plan before editing. Ask the room which decisions are now explicit.
6. Allow the minimal edit in Run B and run the focused test.
7. Compare the two runs using decision ownership and evidence, not verbosity.

## Expected exercise result

The participant should finish with a passing focused test and a one-file change to `src/deploy-gate.mjs`. The exported function and input shape remain unchanged. No test edit, new dependency, I/O, logging, retry, or refactor is needed.

The more important output is the comparison:

| Observation | Vague run | Contract run |
|---|---|---|
| End state | “Make it safe” must be interpreted | Focused test must pass |
| Policy source | Agent must discover or guess | `task.md` is named as authority |
| Allowed files | Unbounded | Source file only unless a test is demonstrably wrong |
| Non-goals | Not stated | Dependencies, I/O, logging, retry, and refactor excluded |
| Completion claim | May be narrative | Must include exact command result and files changed |

The lesson is not that every prompt needs four labelled sections. The lesson is that a task needs a clear goal, the smallest useful context, boundaries that preserve human decisions, and evidence that can falsify the completion claim.

## Common wrong turns

- Updating the tests to match the faulty code. The task says the tests are examples and `task.md` owns the policy.
- Returning a richer object instead of a boolean. That breaks the public contract.
- Adding generic validation without a stated requirement. This expands scope and creates new policy choices.
- Treating a longer answer as a better answer. A concise plan with exact evidence can be superior.
- Running both prompts in the same conversation. The second run would inherit context and invalidate the comparison.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| `node --test` is unavailable | Node.js is missing or too old | Perform the planning comparison only, or use a current Node.js runtime prepared for the workshop. |
| Run A edits immediately | The session was not stopped at the planning boundary | Stop it, discard only this demo's edit, and repeat with “Plan first; do not edit yet.” |
| Run A already gives the ideal solution | The model reconstructed the simple policy | Accept it. Ask whether the same reliability would hold for a larger policy or a fresh teammate without the contract. |
| Run B changes a test | The agent treated executable examples as editable scope | Point back to the boundary and require an explanation of why the test is wrong before allowing that change. |
| The live agent is unavailable | Tool, network, or account issue | Compare the two prompt files manually and walk through the intended decision tree above. |

**Trainer fallback:** show the faulty three-line function, ask the room to translate `task.md` into ordered conditions, then reveal the minimal implementation and the passing test. The learning objective is explicit decision ownership, not a dramatic code-generation result.

## Transfer to a real project

Choose one policy decision with a fast proof command: a Terraform plan gate, image-signing policy, Kubernetes promotion check, or CI release rule. Write down the authority source, immutable interface, prohibited side effects, exact allowed files, and the command that proves success. If the team cannot agree on those items, the blocker is a product or platform decision, not prompt wording.
