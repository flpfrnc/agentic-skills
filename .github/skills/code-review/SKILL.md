---
name: code-review
description: 'Review FastAPI code for SOLID and Hexagonal Architecture compliance. Use when asked to review, audit, or critique PRs, design decisions, or Pydantic v2/FastAPI changes.'
---
# Code Review
Perform an aggressive architecture review focused on SOLID, Hexagonal Architecture, and FastAPI best practices.

## When to Use This Skill
- User asks for a code review, audit, or architecture critique.
- Reviewing FastAPI routing, dependency injection, or Pydantic v2 models.
- Assessing boundaries between domain, adapters, and infrastructure.

## Review Checklist
- SOLID: Dependency Inversion via interfaces; no concrete classes injected into domain logic.
- Hexagonal: domain in `src/domain/`, adapters in `src/adapters/`; reject tight coupling.
- FastAPI: `Annotated` dependencies, Pydantic v2 models, correct status codes, and explicit error handling.
- Tests: run only with explicit approval; otherwise state tests were not run.

## Output Expectations
- Provide prioritized findings with severity and file locations.
- Call out architecture violations and concrete fixes.
- Report whether tests were run and the results.

## Gotchas
- **Never** run tests without explicit approval.
- **Do not** suggest changes that collapse domain and adapter boundaries.

## Troubleshooting
| Issue | Solution |
| --- | --- |
| No tests configured | State tests were not run and ask if a runner exists. |
| Missing architecture boundaries | Recommend refactors that restore `src/domain/` and `src/adapters/` separation. |
