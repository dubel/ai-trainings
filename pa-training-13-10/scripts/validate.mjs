import { existsSync, readFileSync, readdirSync, statSync } from "node:fs";
import { dirname, join, resolve } from "node:path";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("../", import.meta.url));
const htmlPath = join(root, "presentation/index.html");
const html = readFileSync(htmlPath, "utf8");
const failures = [];

const slideCount = (html.match(/<section class="slide\b/g) || []).length;
if (slideCount !== 32) failures.push(`Expected 32 slides, found ${slideCount}`);

const requiredPhrases = [
  "Show of hands",
  "Five adoption levels",
  "Skills are maintained products",
  "Share skills at the narrowest useful scope",
  "Global facts, local rules",
  "Sensitive files need a runtime boundary",
  "Subagent orchestration",
  "Context split decision",
  "Agent teams",
  "Goals and loops",
  "Jev and Needle 3",
  "RTK, Caveman, and Ponytail",
  "Goal, Context, Boundaries, Evidence"
];
for (const phrase of requiredPhrases) {
  if (!html.includes(phrase)) failures.push(`Missing required presentation phrase: ${phrase}`);
}

const assetPattern = /(?:src|href)="([^"#]+)"/g;
for (const match of html.matchAll(assetPattern)) {
  const ref = match[1];
  if (/^(https?:|mailto:)/.test(ref)) continue;
  const localPath = ref.split(/[?#]/, 1)[0];
  const target = resolve(dirname(htmlPath), localPath);
  if (!existsSync(target)) failures.push(`Broken local presentation reference: ${ref}`);
}

function walk(directory) {
  return readdirSync(directory).flatMap((name) => {
    const path = join(directory, name);
    return statSync(path).isDirectory() ? walk(path) : [path];
  });
}

for (const path of walk(root).filter((path) => path.endsWith(".json"))) {
  try {
    JSON.parse(readFileSync(path, "utf8"));
  } catch (error) {
    failures.push(`Invalid JSON in ${path.replace(`${root}/`, "")}: ${error.message}`);
  }
}

const test = spawnSync(process.execPath, ["--test", "demos/01-prompt-contract/test/deploy-gate.test.mjs", "demos/08-goal-loop/test/maintenance-window.test.mjs"], { cwd: root, encoding: "utf8" });
if (test.status === 0) failures.push("Starter tests unexpectedly pass; both goal-oriented exercises must begin with a failing condition");
if (!test.stdout.includes("fail")) failures.push("Starter test run did not report the expected failures");

const hookTest = spawnSync(process.execPath, ["demos/05-sensitive-file-guard/scripts/test-hook.mjs"], { cwd: root, encoding: "utf8" });
if (hookTest.status !== 0) failures.push(`Hook test failed:\n${hookTest.stdout}\n${hookTest.stderr}`);

const ignore = spawnSync("git", ["check-ignore", "-q", "pa-training-13-10/facilitator-script-pl.md"], { cwd: resolve(root, ".."), encoding: "utf8" });
if (ignore.status !== 0) failures.push("facilitator-script-pl.md is not ignored by Git");

if (failures.length) {
  console.error(failures.map((failure) => `- ${failure}`).join("\n"));
  process.exit(1);
}

console.log(`Validated ${slideCount} slides, local references, JSON files, failing starter tests, and the sensitive-file hook.`);
