# PlantUML Azure Sprites

> [!NOTE]
> This is just a test and not intended for any real use.

A test collection of Azure-themed sprites designed for integration with PlantUML diagrams. These sprites enable users to visually represent Azure services and resources within their UML diagrams, enhancing clarity and visual appeal.

## Usage

```md
@startuml
!include https://.../azure-sprites-24.puml

rectangle App <<$vite>>
rectangle AppService <<$containerApp>>

App --> AppService
```
