import { readFileSync } from "node:fs";
import { fileURLToPath } from "node:url";

const rawPath = fileURLToPath(new URL("../fixtures/noisy-ci.log", import.meta.url));
const compactPath = fileURLToPath(new URL("../fixtures/compact-output.txt", import.meta.url));

function metrics(path) {
  const text = readFileSync(path, "utf8");
  return { lines: text.trimEnd().split("\n").length, bytes: Buffer.byteLength(text), text };
}

const raw = metrics(rawPath);
const compact = metrics(compactPath);
console.table([
  { output: "raw training log", lines: raw.lines, bytes: raw.bytes },
  { output: "compact fixture", lines: compact.lines, bytes: compact.bytes }
]);
console.log("\nCompact signal:\n" + compact.text.trim());

