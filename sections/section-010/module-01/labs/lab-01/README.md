---
estimated_duration: 20m
---

# Lab: Record What Cilium Runs On The Cluster

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-010/module-01/labs/lab-01
astrona submit -c sections/section-010/module-01/labs/lab-01
astrona destroy ats-052-lab-010-01-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-agent-image-recorded.sh` | The report names the live agent image |
| `validate-ready-agents-recorded.sh` | The report holds the live number of ready agents |
| `validate-drifter-identity-recorded.sh` | The report holds the live identity of the drifter |
