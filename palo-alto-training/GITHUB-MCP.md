# Multi-Repo Workspace & GitHub MCP Integration

Architecture and guidelines for working across **4 to 5 related repositories** (legacy C++, Go microservices, Terraform) in Claude Code without burning tokens.

---

## 1. Local Workspace vs. GitHub MCP: Clear Separation of Concerns

To avoid burning tokens on repetitive remote API roundtrips, the team follows a two-tier strategy:

```
+-------------------------------------------------------------------------------+
|                       LOCAL MULTI-REPO WORKSPACE                              |
|   [repo-cpp-core]   [repo-cpp-legacy]   [repo-go-service]   [repo-terraform]  |
|                                                                               |
|   * Fast local search (ripgrep / grep)                                        |
|   * Immediate symbol navigation & cross-repo header inspection                |
|   * Local compilation (cl.exe / clang++ / go test)                            |
|   * Zero token burn for reading local files                                   |
+-------------------------------------------------------------------------------+
                                      |
                                      | PRs / Issues / CI Status
                                      v
+-------------------------------------------------------------------------------+
|                             GITHUB MCP SERVER                                 |
|                                                                               |
|   * Inspect PR reviews, comments & CI checks (get_pull_request_status)        |
|   * Read remote issues & acceptance criteria (get_issue)                      |
|   * Create branches & draft verified Pull Requests (create_pull_request)      |
|   * Inspect repos outside the immediate local workspace (fallback only)       |
+-------------------------------------------------------------------------------+
```

### Why Keep Code in a Local Workspace?
1. **Zero-Token Code Exploration:** Local grep and file viewing use local tools. Querying remote repositories via API calls for file searches burns tokens for each HTTP response and tool turn.
2. **Compiler & Test Verification:** C++ builds (MSVC `cl.exe`) and Go tests (`go test ./...`) require local source files on disk. You cannot compile code located only in a remote GitHub repository.
3. **Cross-Repo Refactoring:** When a change spans C++ client headers and a Go microservice API, Claude can edit both directories in the same session and run local tests immediately.

---

## 2. GitHub MCP Capabilities

| Capability | MCP Tools | Use Case in Team Workflow |
|---|---|---|
| **Pull Request Lifecycle** | `create_pull_request`, `get_pull_request`, `get_pull_request_files` | Opening PRs across affected repos with structured descriptions and test tables. |
| **Review Comments & CI** | `get_pull_request_comments`, `get_pull_request_status` | Checking reviewer feedback and CI build statuses without switching windows. |
| **Issue Context** | `get_issue`, `list_issues`, `add_issue_comment` | Bringing acceptance criteria from Jira/GitHub issues directly into the session. |
| **Remote Search (Fallback)** | `search_code`, `get_file_contents` | Inspecting a 6th repository that is not part of the active local workspace. |

---

## 3. Configuration in Claude Code

In `claude.json` or your global settings:

```json
{
  "mcpServers": {
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_PERSONAL_ACCESS_TOKEN": "ghp_your_token_with_repo_scope"
      }
    }
  }
}
```

---

## 4. Recommended Workflow Prompts

### Step 1: Local Cross-Repo Inspection (Workspace)
> *"Inspect `../repo-cpp-core/include/range_check.h` and our local `go-service/policy.go`. Map the data structures across both repositories before proposing any code changes."*

### Step 2: Local Verification
> *"Run `build.bat` in the C++ directory and `go test ./...` in the Go directory. Ensure both test suites pass locally."*

### Step 3: Publish via GitHub MCP
> *"Use GitHub MCP to create a Pull Request on branch `fix/range-check-overflow`. Include a markdown table with 32-bit and 64-bit verification results and link to the relevant Jira issue."*
