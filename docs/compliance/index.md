# EU AI Act Compliance — ROBOT.md

Five RCAN §22-26 attestation packets — FRIA, safety-benchmark, IFU, incident-report, EU-register. Each packet is produced by a `robot-md emit-*` command, signed with the operator's release key, and submitted to RRF intake at `/v2/<packet-type>`. RRF stores the evidence in its transparency log; jurisdictional filing remains the operator's responsibility.

---

<!-- BEGIN: ecosystem certification disclaimer (canonical, derived from spec §10) -->
> **Conformance is not certification.**
>
> Conformance to RCAN tracks (L1–L4 protocol, Gateway Authority, HIL Runtime Safety) is *self-asserted via signed bundles* and *independently replayable from those bundles*. Conformance is not certification. Certification requires audit by a qualified third-party body, which is intentionally out-of-scope for the foundation in 2026.
<!-- END: ecosystem certification disclaimer -->

<!-- BEGIN: ecosystem regulatory disclaimer (canonical, derived from spec §10) -->
> **Compliance evidence is not regulatory sufficiency.**
>
> Compliance packet generation and RRF submission produce *evidence*; they do not constitute regulatory sufficiency in any jurisdiction. Per-jurisdiction conformity assessments and notified-body engagement are the user's responsibility, in consultation with qualified counsel.
<!-- END: ecosystem regulatory disclaimer -->

---

## § 01 — The 5 packets

Five attestation packets. One command each. Each packet covers a different EU AI Act obligation. All are signed with your robot's key and routed to the live RRF endpoint.

### §22 — FRIA (Fundamental Rights Impact Assessment)

**EU AI Act Art. 9:** pre-deployment assessment of impact on fundamental rights. Automated checklist derived from ROBOT.md capabilities, safety gates, and RCAN LoA level. Filed before first deployment.

```bash
# emit + sign + submit
robot-md emit-fria ROBOT.md \
  --sign --submit
```

Endpoint: `/v2/fria` — [robotregistryfoundation.org](https://robotregistryfoundation.org)

---

### §23 — Safety benchmark (ISO 42001 self-assessment)

**ISO 42001 + RCAN §23:** structured safety self-assessment linked to the robot's RRN. Covers hazard analysis, control measures, and residual risk. Signed envelope with audit-trail hash.

```bash
robot-md emit-safety-benchmark ROBOT.md \
  --sign --submit
```

Endpoint: `/v2/safety-benchmark`

---

### §24 — IFU Art. 13(3) (Instructions for Use)

**EU AI Act Art. 13(3):** machine-readable instructions for use — what the robot can and cannot do, under what conditions, with what safety constraints. Derived from ROBOT.md capabilities and body sections.

```bash
robot-md emit-ifu ROBOT.md \
  --sign --submit
```

Endpoint: `/v2/ifu`

---

### §25 — Incident report (Art. 72 serious incident notification)

**EU AI Act Art. 72:** structured incident report — timestamped, linked to RRN, signed. Required within 15 days of a serious incident. robot-md provides the structure; the operator provides the incident narrative.

```bash
robot-md emit-incident-report ROBOT.md \
  --description "..." \
  --sign --submit
```

Endpoint: `/v2/incident-report`

---

### §26 — EU Register Art. 49 (Per-model EU AI Act registration)

**EU AI Act Art. 49:** registration of the AI system in the EU database. Requires an RMN (model number). Routed through RRF to the official register endpoint. robot-md handles the RCAN-signed envelope.

```bash
robot-md emit-eu-register ROBOT.md \
  --sign --submit
```

Endpoint: `/v2/eu-register`

---

## § 02 — Status check

Check filing status in one command.

```bash
robot-md compliance status ./ROBOT.md
```

Example output:

```
# robot-md compliance status ./ROBOT.md
# RRN: RRN-000000000003  |  RMN: RMN-000000000004

✓  fria              ACCEPTED  2026-04-24T11:32:01Z
✓  safety-benchmark  ACCEPTED  2026-04-24T11:33:15Z
✓  ifu               ACCEPTED  2026-04-24T11:34:02Z
✓  incident-report   NONE      no incidents filed
✓  eu-register       ACCEPTED  2026-04-24T11:35:40Z

Ready for submission · 4/5 packets filed · 0 incidents
```

Note: pass the **file path** (`./ROBOT.md`), not a directory, to avoid issue [#32](https://github.com/RobotRegistryFoundation/robot-md/issues/32) (directory-vs-file resolution bug, tracked).

---

## § 03 — Identity prerequisite

**Register first. File second.**

All five compliance packets require a valid RRN. Run `robot-md register ROBOT.md` before emitting any packets. See the [Registry page](https://robotmd.dev/registry/) for the full registration flow including key generation and RMN assignment.

For RCAN compatibility requirements, see [rcan.dev/compatibility](https://rcan.dev/compatibility).

---

## Next steps

- [Register your robot →](https://robotmd.dev/registry/)
- [Let Compliance-bot file for you →](https://robotmd.dev/agents/#managed)
- [RRF live endpoints →](https://robotregistryfoundation.org)
