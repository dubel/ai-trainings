import test from "node:test";
import assert from "node:assert/strict";
import { insideWindow } from "../src/maintenance-window.mjs";

test("start is inclusive and end is exclusive", () => {
  assert.equal(insideWindow(60, 60, 90), true);
  assert.equal(insideWindow(89, 60, 90), true);
  assert.equal(insideWindow(90, 60, 90), false);
});

test("outside minutes are rejected", () => {
  assert.equal(insideWindow(59, 60, 90), false);
  assert.equal(insideWindow(91, 60, 90), false);
});

