import assert from "node:assert/strict";
import { spawnSync } from "node:child_process";
import { fileURLToPath } from "node:url";

const hook = fileURLToPath(new URL("./block-sensitive-read.mjs", import.meta.url));
const cases = [
  { name: "safe source", blocked: false, input: { tool_name: "Read", tool_input: { file_path: "src/app.mjs" } } },
  { name: "safe env example", blocked: false, input: { tool_name: "Read", tool_input: { file_path: ".env.example" } } },
  { name: "root env", blocked: true, input: { tool_name: "Read", tool_input: { file_path: ".env" } } },
  { name: "nested env", blocked: true, input: { tool_name: "Read", tool_input: { file_path: "services/api/.env.production" } } },
  { name: "Windows secret", blocked: true, input: { tool_name: "Write", tool_input: { file_path: "infra\\secrets\\prod.json" } } },
  { name: "Bash cat env", blocked: true, input: { tool_name: "Bash", tool_input: { command: "cat .env" } } },
  { name: "private key", blocked: true, input: { tool_name: "PowerShell", tool_input: { command: "Get-Content certs/prod.key" } } }
];

for (const entry of cases) {
  const result = spawnSync(process.execPath, [hook], { input: JSON.stringify(entry.input), encoding: "utf8" });
  assert.equal(result.status === 2, entry.blocked, `${entry.name}: ${result.stderr}`);
}

console.log(`Sensitive-file hook: ${cases.length} cases passed.`);

