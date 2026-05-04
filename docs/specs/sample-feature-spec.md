# Sample Feature Spec: Widget Registry

## Goal
Provide a minimal widget registry API to demonstrate spec format and unit-based implementation.

## Scope
- Create a simple in-memory registry with create, list, and get endpoints.
- Keep business logic isolated from routing.

## FastAPI Endpoints
- POST /widgets
- GET /widgets
- GET /widgets/{widget_id}

## Pydantic Models
- WidgetCreate: name: str, description: str | None
- Widget: id: str, name: str, description: str | None
- WidgetList: items: list[Widget]

## Interfaces
- WidgetRepository
  - add(widget: WidgetCreate) -> Widget
  - list() -> list[Widget]
  - get(widget_id: str) -> Widget | None

## Implementation Units
- [ ] Unit 1: Define domain models and repository interface in src/domain/.
- [ ] Unit 2: Implement in-memory repository in src/services/.
- [ ] Unit 3: Add FastAPI routes and dependency wiring in src/adapters/ or src/routes/.
