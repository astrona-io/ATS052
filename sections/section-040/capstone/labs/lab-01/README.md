---
estimated_duration: 30m
---

# Lab: Component Roles Capstone

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-040/capstone/labs/lab-01
astrona submit -c sections/section-040/capstone/labs/lab-01
astrona destroy ats-052-lab-040-cap
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-operator-ha-on-two-nodes.sh` | Two operator replicas run on two different nodes |
| `validate-agents-debug-and-ready.sh` | Debug is on, the agents were restarted and all are ready |
| `validate-relay-restored.sh` | Hubble Relay is available and its Service has an endpoint |
