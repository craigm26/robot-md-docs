# ROBOT.md Examples

These are example `ROBOT.md` files for different robot types. Each file is a complete, valid ROBOT.md manifest you can copy and adapt for your own hardware.

All examples are RCAN-conformant — see [rcan.dev/compatibility](https://rcan.dev/compatibility) for the current protocol requirements.

---

## Examples

### [bob](bob.md) — Raspberry Pi 5 arm + camera

A Raspberry Pi 5 workstation robot with a 6-DOF SO-ARM101 follower arm and Luxonis OAK-D stereo camera. The canonical example deployment for the OpenCastor runtime. Full compliance block, full brain config, 5 capabilities.

**Key features:** `arm+camera` type, 6 DoF, `pqc-hybrid-v1` signing, `eu_ai_act` compliance, Claude Opus 4.7 planner.

---

### [minimal](minimal.md) — Bare minimum valid manifest

The smallest valid `ROBOT.md`. Every field present is required; nothing extra is set. Use this as the starting point for a new robot.

**Key features:** `wheeled` type, 2 DoF, no capabilities declared, software E-stop only.

---

### [so-arm101](so-arm101.md) — Hugging Face SO-ARM101 generic preset

The Hugging Face SO-ARM101 open-source 6-DOF follower arm kit (~$300 BOM). Generic preset — copy and customize for your build. No camera, no brain: add a `brain:` block when you wire up a planner.

**Key features:** `arm` type, 6 DoF, 4 capabilities, Feetech STS3215 servos.

---

### [turtlebot4](turtlebot4.md) — Clearpath TurtleBot 4 Lite

A Clearpath TurtleBot 4 Lite running OpenCastor over ROS 2. Two-wheeled differential drive, RPLIDAR A1, PiCamera 2, controlled via Claude Sonnet.

**Key features:** `wheeled` type, 2 DoF, ROS 2 driver, navigation + vision capabilities.

---

## How to use an example

1. Copy the example file to your project as `ROBOT.md`
2. Edit the `metadata` section: set `robot_name`, `rrn`, `manufacturer`, `model`
3. Update `physics`, `drivers`, `capabilities` to match your hardware
4. Add a `brain:` block if your robot uses an LLM planner
5. Validate: `robot-md validate ROBOT.md`
6. Register: `robot-md register ROBOT.md`

See the [spec](../spec/v1.md) for the full field reference.
