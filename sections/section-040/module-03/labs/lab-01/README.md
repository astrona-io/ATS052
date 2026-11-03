---
estimated_duration: 25m
---

# Lab: Restore Hubble Relay And Read Its Service

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-040/module-03/labs/lab-01
astrona submit -c sections/section-040/module-03/labs/lab-01
astrona destroy ats-052-lab-040-03-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-relay-is-available.sh` | Hubble Relay has one available replica |
| `validate-relay-service-has-endpoint.sh` | The Service hubble-relay has an endpoint address |
| `validate-relay-port-recorded.sh` | The report holds the live relay Service port |
| `validate-peer-port-recorded.sh` | The report holds the live peer Service port |
