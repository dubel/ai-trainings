import process from "node:process";

let raw = "";
for await (const chunk of process.stdin) raw += chunk;

let request;
try {
  request = JSON.parse(raw);
} catch {
  console.error("Blocked: hook input was not valid JSON");
  process.exit(2);
}

const tool = String(request.tool_name || "");
const input = request.tool_input || {};
const candidate = String(input.file_path || input.path || input.command || "").replaceAll("\\", "/");
const withoutExample = candidate.replaceAll(".env.example", "safe-example");
const sensitive = [
  /(^|[\s'\"/])(?:\.\/)?\.env(?:$|[./\s'\"])/i,
  /(^|[\s'\"/])secrets?(?:\/|$)/i,
  /(^|[\s'\"/])[^/\s]+\.(?:pem|key)(?:$|[\s'\"])/i
];

if (sensitive.some((pattern) => pattern.test(withoutExample))) {
  console.error(`Blocked: ${tool || "tool"} request targets a protected secret path`);
  process.exit(2);
}

process.exit(0);
