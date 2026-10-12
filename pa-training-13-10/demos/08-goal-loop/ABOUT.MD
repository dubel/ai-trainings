# About this demo

## Quick orientation

This demo contrasts two control loops that solve different problems. `/goal` lets an agent act and self-correct toward a measurable condition. `/loop` wakes the session later to inspect state that may have changed outside the agent.

The easy mistake is to use time-based polling for a task the agent could finish directly, or to use a goal for a rollout whose state changes only with time and external systems.

## Part A: goal at a glance

The maintenance-window function currently treats both boundaries as inclusive:

```js
return currentMinute >= startMinute && currentMinute <= endMinute;
```

The tests define a half-open interval: start is inclusive and end is exclusive. Therefore minute 60 is inside `[60, 90)`, minute 89 is inside, and minute 90 is outside.

The intended code change is deliberately minimal:

```js
return currentMinute >= startMinute && currentMinute < endMinute;
```

## Goal reasoning path

1. Turn the request into an observable finish line: the focused test exits `0`.
2. Add boundaries: only `src/maintenance-window.mjs` may change and the public function signature remains stable.
3. Add a budget: stop after ten turns instead of retrying indefinitely.
4. Run the failing test and identify the single boundary mismatch.
5. Make the smallest change, rerun the test, and surface the actual result in the transcript.
6. Let the evaluator judge the transcript evidence. Remember that it does not independently inspect files or rerun commands.
7. Stop when the condition is proven; do not continue refactoring.

## Expected goal result

`node --test test/maintenance-window.test.mjs` exits successfully, only `src/maintenance-window.mjs` changes, and `insideWindow(currentMinute, startMinute, endMinute)` keeps its signature. The transcript contains the passing command output so the goal evaluator can see the evidence.

If the test passes but the evidence is not surfaced, the evaluator may correctly refuse completion. That is an observability problem in the agent loop, not a reason to weaken the goal.

## Part B: loop at a glance

`status/deploy-status.json` is a local stand-in for an external rollout. The full loop instruction in `.claude/loop.md` compares:

- `phase`;
- `ready` and `desired` progress;
- `failedChecks`;
- stop states `COMPLETE` and `FAILED`.

For this workshop, treat `.claude/loop.md` as the authoritative behavior. An unchanged file produces no update. Readiness progress, a new failed check, completion, failure, or required human action produces one concise update. `COMPLETE` or `FAILED` stops the loop.

## Suggested simulated sequence

1. Start with `ROLLING_OUT`, ready `2/4`, and no failed checks.
2. Leave the file unchanged for one iteration. Expected result: silence.
3. Change ready to `3` and advance `observedAt`. Expected result: one-line progress update.
4. Optionally add a failed check. Expected result: one-line failure or action update, without repeating the full history.
5. Set ready to `4`, phase to `COMPLETE`, clear failed checks, and advance time. Expected result: completion update and loop termination.

The human edits the fixture between iterations. The agent does not mutate a cluster, deployment, or cloud account.

## Loop reasoning path

1. Identify that the agent cannot make the rollout advance by reasoning harder.
2. Select the smallest state snapshot needed for comparison.
3. Define meaningful change and an explicit quiet condition.
4. Define terminal states before starting.
5. Choose a reasonable interval and cost budget.
6. Report deltas, not the entire status on every wake-up.
7. Use a durable scheduler, CI, or cloud routine if observation must survive independently of the open session.

## Expected exercise result

Participants should be able to complete this sentence:

> A goal repeats action and evaluation until a condition is proven; a loop repeats observation because time or an external system may change the condition.

They should also produce one bounded goal and one quiet loop for a real engineering workflow. Both need stop conditions. The goal additionally needs a proof command and action boundaries; the loop needs a change detector and notification policy.

## Common wrong turns

- Writing “fix the bug” as a goal with no proof or budget.
- Assuming the evaluator independently runs tests.
- Continuing to refactor after the test proves completion.
- Polling every few seconds only to make the demo feel faster.
- Reporting identical status every iteration.
- Forgetting a terminal state, causing an indefinite loop.
- Using an open-session loop for work that must survive a closed laptop or process restart.
- Allowing the loop to mutate production as part of observation.

## Troubleshooting and fallback

| Problem | Likely cause | Action / fallback |
|---|---|---|
| `/goal` or `/loop` is unavailable | Installed Claude Code version or feature set differs | Execute the same pattern manually: bounded edit-test iterations for the goal and timed reads for the loop. |
| The goal never completes after a passing test | Command evidence was not surfaced to the evaluator | Run the exact command again and include the exit result in the transcript. |
| The goal edits tests | File boundaries were not respected | Stop, restore only the demo changes, and restate that only the source file may change. |
| The loop is noisy | Meaningful change and quiet behavior are underspecified | Use `.claude/loop.md` and report only deltas. |
| The loop does not notice readiness progress | A shorter prompt watches only phase and failures | Use the full loop file and explicitly include `ready` and `desired`. |
| Waiting would consume workshop time | The interval is intentionally realistic | Simulate iterations manually by rereading the fixture after each prepared edit. |

**Trainer fallback:** fix the one-character boundary bug manually, run the test, then show three prepared versions of the status JSON as consecutive snapshots. Ask the room when to speak and when to stop.

## Transfer to a real project

Use goals for bounded repair, queue draining, test stabilization, or migrations with measurable exit conditions. Use loops for rollout observation, asynchronous builds, approvals, or external status. Set time or turn limits, quiet conditions, terminal states, and human escalation. Move persistent monitoring to infrastructure designed to survive independently of a developer session.
