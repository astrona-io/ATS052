---
estimated_duration: 30m
---

# Lab: IPAM Capstone

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-030/capstone/labs/lab-01
astrona submit -c sections/section-030/capstone/labs/lab-01
astrona destroy ats-052-lab-030-cap
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-pool-amber-exists.sh` | The pool amber has the CIDR 10.30.0.0/16 and mask size 24 |
| `validate-probe-template-annotated.sh` | The probe pod template selects the pool amber |
| `validate-probe-pods-use-amber.sh` | Every running probe pod has an address from 10.30.0.0/16 |
| `validate-shuttle-on-default-and-working.sh` | shuttle keeps its default-pool address and reaches probe |
