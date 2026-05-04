---
name: handoff
description: 'Summarize session state into docs/HANDOFF.md. Use when pausing work, switching agents, or ending a session and you need a concise resume point.'
---
# Handoff
Capture the current session state so another agent can resume quickly.

## When to Use This Skill
- User asks for a handoff, summary, or "pause and resume later".
- You are ending a session or switching agents.
- Work is mid-implementation and needs a clean resume point.

## Workflow
1. Read the active spec in `docs/specs/` (if present) and identify the current implementation unit.
2. Overwrite `docs/HANDOFF.md` using the exact headers below, in this order.
3. Use `# Handoff` for the first header and `##` for the rest.
4. Be concise but information-dense. No filler. Each section must have at least one bullet.
5. Include file paths for any changes, and list any uncommitted or pending work explicitly.
6. For tests/commands, include the exact command and the outcome (pass/fail/not run).
7. For Next Steps, use a numbered list with the most critical step first.
8. End with: "Handoff complete. The next agent can read docs/HANDOFF.md to resume."

## Required Section Headers (in order)
- Handoff
- Current Goal
- Work Completed
- Decisions and Assumptions
- Current State
- Files Touched
- Commands and Tests Run
- Open Questions and Blockers
- Next Steps (Ordered)
- Risks and Notes

## Gotchas
- **Do not append**; always overwrite `docs/HANDOFF.md`.
- **Never omit** command/test outcomes; write "not run" if needed.

## Troubleshooting
| Issue | Solution |
| --- | --- |
| No active spec found | Note this in "Current State" and "Risks and Notes". |
| No files changed | Write "None" under "Files Touched". |
