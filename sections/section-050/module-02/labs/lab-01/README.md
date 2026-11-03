---
estimated_duration: 30m
---

# Lab: Fix Native Routing Between Nodes

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-050/module-02/labs/lab-01
astrona submit -c sections/section-050/module-02/labs/lab-01
astrona destroy ats-052-lab-050-02-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-direct-node-routes-enabled.sh` | auto-direct-node-routes is "true" and routing stays native |
| `validate-agents-restarted-and-ready.sh` | The agents were restarted and are ready |
| `validate-cross-node-request-works.sh` | shuttle reaches probe across nodes |
