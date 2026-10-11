# Exercise 08 — Goals and loops

## Goal

Use `/goal` for self-correcting work with a measurable finish line, then use `/loop` for time-based observation.

## Part A: goal

The sample maintenance-window check has a boundary bug.

```bash
node --test test/maintenance-window.test.mjs
```

Set a bounded goal:

```text
/goal node --test test/maintenance-window.test.mjs exits 0, only src/maintenance-window.mjs changes, the public function signature stays unchanged, or stop after 10 turns
```

Review the evaluator's evidence. The evaluator reads what Claude surfaced in the transcript; it does not independently run commands or inspect files.

## Part B: loop

Use the local deployment fixture as a stand-in for changing external state:

```text
/loop 2m read status/deploy-status.json; report only if phase or failedChecks changed; stop when phase is COMPLETE or FAILED
```

Edit the fixture manually between iterations to simulate a rollout. Do not shorten the interval in a production environment just to make the demo faster.

## Decision rule

- Use `/goal` when the agent can act toward a completion condition and prove progress with a check.
- Use `/loop` when time or an external system changes the state and the useful action is to inspect again.
- Use a cloud routine, desktop scheduled task, or CI scheduler when work must survive independently of the open session.

## Use it in your project

Write goals around exit codes, test results, file counts, or clean queues. Add a turn or time limit. Write loops with a quiet condition: no update while state is unchanged, notify on meaningful change, failure, completion, or required human action.

