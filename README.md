# Agentic Skills Repository

This repository contains GitHub Copilot agents, skills, and MCP configuration for agentic workflows.

## Contents
- Agents:
  - Architect: .github/agents/architect.agent.md
  - Implementer: .github/agents/implementer.agent.md
- Skills:
  - Create spec: .github/skills/create-spec/SKILL.md
  - Code review: .github/skills/code-review/SKILL.md
  - Handoff: .github/skills/handoff/SKILL.md
- MCP config: .vscode/mcp.json
- Sample spec: docs/specs/sample-feature-spec.md

## Conventions (Awesome Copilot-aligned)
- Agent and skill files use YAML frontmatter with single-quoted `description` values.
- Skill descriptions are keyword-rich and include explicit "when to use" triggers for auto-discovery.
- Agent `tools` follow least-privilege; add `execute` only when terminal work is required.
- Agents specify a `model` in frontmatter; adjust to the model available in your Copilot environment.
- SKILL.md bodies include "When to Use", "Workflow", and "Gotchas" sections for high-signal guidance.
- Filenames and folders use lowercase with hyphens.

## How to Use in Your Work Repos
To maintain a single source of truth for your agents while keeping them accessible in projects like expense_viewer, use the Submodule + Symlink approach.

1. Add and init the submodule via the setup script:

```bash
# Run from your target repo root
curl -sSL https://raw.githubusercontent.com/flpfrnc/agentic-skills/main/setup-agents.sh | bash -s -- add
curl -sSL https://raw.githubusercontent.com/flpfrnc/agentic-skills/main/setup-agents.sh | bash -s -- init
```

> If you already have this repo cloned locally, replace the curl command with the local script path.

2. Create agent symlinks
> This repository includes a setup-agents.sh script that automatically creates the necessary symbolic links in .github/agents/, ensuring Copilot discovers them regardless of your OS (Windows/Git Bash, macOS, or Linux).

```bash
# Run from your target repo root
sh libs/agentic-skills/setup-agents.sh create-link
```

Visual Example (Target Repo Structure)
```
work-repo/
├── .github/
│   └── agents/           
│       ├── architect.agent.md   --> (link to libs/agentic-skills/...)
│       └── implementer.agent.md --> (link to libs/agentic-skills/...)
├── libs/
│   └── agentic-skills/    <-- The actual submodule
├── src/
└── README.md
```

Notes:
- Copilot discovers agents/skills from the workspace root. If they live under a subfolder or submodule, you may need a multi-root workspace or a copy into the repo root.
- The MCP config is optional. Use it only when you want local execution tooling.

## MCP Wiring for Private Repos (Step-by-step)
1. Integrate the subtree.
2. Ensure .vscode/mcp.json exists at the work repo root.
3. If needed, narrow the default scope by replacing ${workspaceFolder} with a subpath.
4. Install prerequisites: Node.js (for npx), uv (for uvx), and Git.
5. macOS/Linux defaults:
  - Use npx directly for Node-based servers.
  - Use uvx for Python-based servers.
6. Open the work repo in VS Code, trust the workspace, and reload the window.
7. Verify tools by asking Copilot to perform a simple file or git action.

## Strict MCP Profile
Use minimal local-only servers and pin versions.

Example (drop-in replacement for .vscode/mcp.json):
```
{
  "servers": {
    "filesystem": {
      "command": "npx",
      "args": [
        "-y",
        "@modelcontextprotocol/server-filesystem@2026.1.14",
        "${workspaceFolder}"
      ]
    },
    "git": {
      "command": "uvx",
      "args": ["mcp-server-git@2026.1.14", "--repository", "${workspaceFolder}"]
    }
  }
}
```

Pin versions:
- Node server version: npm view @modelcontextprotocol/server-filesystem version
- Python server version: uvx mcp-server-git@2026.1.14 --help

## Security Checklist
- Scope filesystem access to a single repo path.
- Avoid network-enabled servers unless required.
- Pin versions for all MCP servers.
- Keep MCP config out of git if it contains local paths or tokens.
- Review tool calls before approval.

## RTK + Copilot (Local-only Token Savings)
RTK is a local CLI proxy that compresses shell command output before it reaches the model. It does not require MCP.

Setup (macOS/Linux):
```
brew install rtk
rtk init -g --copilot
```

Notes:
- Restart VS Code/Copilot after init.
- The auto-rewrite hook only applies to Bash tool calls; built-in tools like Read/Grep/Glob are not rewritten.
- For maximum savings, use shell commands (git, rg, cat) or call rtk explicitly (rtk read, rtk grep).

Telemetry (optional, local-only):
```
export RTK_TELEMETRY_DISABLED=1
rtk telemetry disable
```

## Typical Flow
1. Ask @Architect to create a spec.
2. Ask @Implementer to implement one unit.
3. Ask @Architect to review the unit.
4. Ask for a handoff when pausing.
