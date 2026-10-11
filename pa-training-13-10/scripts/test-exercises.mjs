import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const root = fileURLToPath(new URL("../", import.meta.url));
const starters = spawnSync(process.execPath, [
  "--test",
  "demos/01-prompt-contract/test/deploy-gate.test.mjs",
  "demos/08-goal-loop/test/maintenance-window.test.mjs"
], { cwd: root, encoding: "utf8" });

if (starters.status === 0 || !starters.stdout.includes("fail 4")) {
  console.error("Expected four intentional starter failures.\n" + starters.stdout + starters.stderr);
  process.exit(1);
}

const hook = spawnSync(process.execPath, ["demos/05-sensitive-file-guard/scripts/test-hook.mjs"], { cwd: root, encoding: "utf8" });
if (hook.status !== 0) {
  console.error(hook.stdout + hook.stderr);
  process.exit(1);
}

console.log("Exercise checks passed: four intentional starter failures and seven sensitive-file hook cases confirmed.");

