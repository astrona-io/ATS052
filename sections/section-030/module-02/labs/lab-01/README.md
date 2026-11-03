---
estimated_duration: 25m
---

# Lab: Trace A Pod Address To Its Node Allocation

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-030/module-02/labs/lab-01
astrona submit -c sections/section-030/module-02/labs/lab-01
astrona destroy ats-052-lab-030-02-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-probe-ip-recorded.sh` | The report holds the live pod IP |
| `validate-probe-node-recorded.sh` | The report names the live node of the pod |
| `validate-node-cidr-recorded.sh` | The report holds the CiliumNode slice of that node |
