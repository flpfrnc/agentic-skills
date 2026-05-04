---
name: create-spec
description: 'Analyze a codebase and write a Markdown feature spec with implementation units. Use when asked to create a spec, plan a feature, draft a design doc, or break work into steps for FastAPI and Pydantic v2 services.'
---
# Create Spec
Generate a concise technical specification for a new feature, aligned to the repo architecture.

## When to Use This Skill
- User asks for a spec, design doc, or technical plan.
- User wants a feature broken into step-by-step implementation units.
- User needs FastAPI endpoints, Pydantic models, or interfaces enumerated.

## Workflow
1. Identify the core requirement and feature name. Ask only blocking questions.
2. Use the Explore subagent to scan `src/` (and `docs/` if needed) and summarize relevant architecture and patterns.
3. Enforce Hexagonal/Clean Architecture boundaries (domain in `src/domain/`, adapters in `src/adapters/`).
4. Write `docs/specs/{feature-name}-spec.md` using the spec format below.
5. Specify exact FastAPI endpoints, Pydantic v2 models, and interfaces required.
6. Break work into "Implementation Units" (max ~50 LOC each) with clear file targets.
7. Be assertive: choose sensible defaults, state assumptions, and ask questions only when blocked.

## Spec Format
Use this section order (match the sample spec):
- Goal
- Scope
- FastAPI Endpoints
- Pydantic Models
- Interfaces
- Implementation Units

## Gotchas
- **Do not** mix routing logic into `src/domain/`; keep domain pure.
- **Keep units small** so the implementer can complete one unit per pass.

## References
- ../../../docs/specs/sample-feature-spec.md
