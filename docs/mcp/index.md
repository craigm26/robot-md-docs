# robot-md-mcp — MCP Server for ROBOT.md

**Advisory Mode only.** This npm package exposes the manifest as MCP resources plus `validate` and `render` tools. It does not expose actuator commands. To let an agent move hardware, install [`robot-md-gateway`](https://github.com/RobotRegistryFoundation/robot-md-gateway) — the mandatory exclusive path between agent intent and any motor.

This MCP server exposes a robot's `ROBOT.md` as MCP resources, plus two tools: `validate` (check a manifest against the schema) and `render` (produce a human- or agent-readable view). Read-only. **By design, it has no actuator tools.** Anything that physically moves a robot goes through `robot-md-gateway` at Layer 3. One `npx` command. Zero config files.

---

## § 01 — Install

### Claude Code (fastest)

```bash
claude mcp add robot-md -- npx -y robot-md-mcp ./ROBOT.md
```

### Standalone (any harness)

```bash
npx robot-md-mcp /absolute/path/to/ROBOT.md
```

Requires Node 18.20+. Uses stdio transport — no network ports, no auth config. The server re-reads the file on every call (no cache, no watcher).

---

## § 02 — MCP surface

4 resources + 2 tools.

Resources the agent reads at will. Tools the agent invokes on request.

| Type | Name | URI | Description | Returns |
|---|---|---|---|---|
| Resource | `frontmatter` | `robot-md://<name>/frontmatter` | Full YAML frontmatter parsed to JSON. Contains identity, physics, drivers, safety, capabilities, compliance. | `application/json` |
| Resource | `capabilities` | `robot-md://<name>/capabilities` | Array of capability strings from `capabilities[]` in frontmatter. | `application/json` |
| Resource | `safety` | `robot-md://<name>/safety` | Safety block: estop config, hitl_gates, max velocities, payload limits. | `application/json` |
| Resource | `body` | `robot-md://<name>/body` | Markdown prose body: Identity, What X Can Do, Safety Gates, Task Routing sections. | `text/markdown` |
| Tool | `validate` | (invocable) | Validate the loaded ROBOT.md against JSON Schema and RCAN conformance rules. | `{ ok: bool, summary: string, errors: string[] }` |
| Tool | `render` | (invocable) | Emit canonical YAML of the frontmatter — normalized key order, no comments. | `string (YAML)` |

---

## § 03 — Quickstart

First tool call in 30 seconds.

```bash
# 1. Wire the MCP server:
$ claude mcp add robot-md -- npx -y robot-md-mcp ./ROBOT.md

# 2. Open Claude Code from your project root:
$ claude

# 3. Confirm the server is connected:
> /mcp
● robot-md  connected
    resources: frontmatter, capabilities, safety, body
    tools:     validate, render

# 4. Ask your robot what it can do:
> what can this robot do?
[reads robot-md://my-robot/capabilities]
This robot exposes 5 capabilities: arm.pick, arm.place,
arm.reach, vision.describe, status.report...
```

---

## § 04 — Any harness

The underlying `npx -y robot-md-mcp /path/to/ROBOT.md` command is the same for every harness. Registration syntax varies.

| Harness | How to add |
|---|---|
| Claude Code CLI | `claude mcp add robot-md -- npx -y robot-md-mcp ./ROBOT.md` |
| Claude Desktop | JSON snippet in `claude_desktop_config.json` — see [Claude Code page](https://robotmd.dev/agents/claude-code/) |
| Gemini CLI | `gemini mcp add robot-md npx -y robot-md-mcp ./ROBOT.md` |
| OpenAI Codex CLI | `--mcp-server` flag + `--dangerously-bypass` |
| Cursor / Zed / Cline | MCP settings: `command=npx`, `args=["-y","robot-md-mcp","./ROBOT.md"]` |

---

## Next steps

- [Claude Code install →](https://robotmd.dev/agents/claude-code/)
- [ROBOT.md spec →](../spec/index.md)
- [npm: robot-md-mcp →](https://www.npmjs.com/package/robot-md-mcp)
- [GitHub →](https://github.com/RobotRegistryFoundation/robot-md-mcp)

---

<!-- BEGIN: ecosystem authority disclaimer (canonical, derived from spec §10) -->
> **Where safety is actually enforced.**
>
> Physical safety is enforced at Layer 3 (`robot-md-gateway`) or Layer 4 (a runtime that embeds it, e.g., OpenCastor). Declaration alone (Layer 1) does not enforce safety. Agent host alone (Layer 2) is not the safety boundary. If a deployment lacks Layer 3, no safety claim attaches to it.
<!-- END: ecosystem authority disclaimer -->
