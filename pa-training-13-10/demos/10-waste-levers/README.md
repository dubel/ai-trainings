# Exercise 10 — RTK, Caveman, and Ponytail

## Goal

Apply three different waste controls without confusing their effects.

## Part A: RTK-style terminal compression

```bash
node scripts/compare-output.mjs
```

Compare `fixtures/noisy-ci.log` with `fixtures/compact-output.txt`. Confirm that the compact output preserves the failing check, resource, line, and summary. This is a labelled training fixture, not an RTK benchmark.

## Part B: Caveman-style status

Write an incident update in no more than seven lines. Preserve:

- failed component;
- exact error;
- first failing time;
- user impact;
- what was verified;
- what remains unverified;
- next owner or check.

Compare with `expected-incident-update.md`.

## Part C: Ponytail-style review

Review `fixtures/proposed-fix.diff`. Identify speculative abstractions, dependencies, or unrelated cleanup. Propose the smallest change that satisfies the failing check.

## Use it in your project

Measure each layer independently:

- RTK: terminal bytes and retained signal;
- Caveman: response tokens and missing facts;
- Ponytail: changed lines and acceptance criteria.

A reduced terminal log does not imply the whole session costs less by the same percentage. A smaller diff cannot omit a required case.

