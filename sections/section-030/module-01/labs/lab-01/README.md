---
estimated_duration: 20m
---

# Lab: Record The IPAM Mode And Pool Settings

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-030/module-01/labs/lab-01
astrona submit -c sections/section-030/module-01/labs/lab-01
astrona destroy ats-052-lab-030-01-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-ipam-mode-recorded.sh` | The report names the live IPAM mode |
| `validate-pool-cidr-recorded.sh` | The report holds the live pool CIDR |
| `validate-mask-size-recorded.sh` | The report holds the live mask size |
