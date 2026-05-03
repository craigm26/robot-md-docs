# ROBOT.md Format Specification

`ROBOT.md` is a single file that declares what a robot **is** and what it **can do**, in a form that both machines (JSON Schema + RCAN validators) and LLM planners can consume directly.

The file is markdown with a leading YAML frontmatter block:

- The **frontmatter** is the machine-readable declaration: identity, physics, drivers, safety, capabilities, compliance. Validated against `schema/v1/robot.schema.json`.
- The **body** is human/LLM prose: identity narrative, capabilities explained, safety gates described, task-routing guidance. Read by the planner at session start.

This parallels `CLAUDE.md`'s role for codebases: a single file, read at session start, that orients the planner.

## Spec versions

| Version | Status | Document |
|---|---|---|
| v1 | Current | [v1.md](v1.md) |
| v0.2 design | Historical | [v0.2-design.md](v0.2-design.md) |
| v0.1 MCP design | Historical | [v0.1-mcp-design.md](v0.1-mcp-design.md) |

## JSON Schema

The machine-readable schema is served at:

```
https://robotmd.dev/schema/v1/robot.schema.json
```

Validate a local file:

```bash
robot-md validate ROBOT.md
```

## Links

- [Full spec (v1)](v1.md)
- [JSON Schema](https://robotmd.dev/schema/v1/robot.schema.json)
- [RCAN compatibility matrix](https://rcan.dev/compatibility)
- [Robot Registry Foundation](https://robotregistryfoundation.org/)
- [GitHub](https://github.com/RobotRegistryFoundation/robot-md)
