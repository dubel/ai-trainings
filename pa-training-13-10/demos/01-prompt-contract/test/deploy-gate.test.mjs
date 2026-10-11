import test from "node:test";
import assert from "node:assert/strict";
import { canDeploy } from "../src/deploy-gate.mjs";

test("rejects every destructive plan", () => {
  assert.equal(canDeploy({ environment: "staging", planHasDestroy: true, approvals: 9 }), false);
});

test("production requires two approvals", () => {
  assert.equal(canDeploy({ environment: "production", planHasDestroy: false, approvals: 1 }), false);
  assert.equal(canDeploy({ environment: "production", planHasDestroy: false, approvals: 2 }), true);
});

test("non-production requires one approval", () => {
  assert.equal(canDeploy({ environment: "staging", planHasDestroy: false, approvals: 0 }), false);
  assert.equal(canDeploy({ environment: "staging", planHasDestroy: false, approvals: 1 }), true);
});

