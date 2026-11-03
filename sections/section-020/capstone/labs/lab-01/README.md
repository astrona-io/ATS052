---
estimated_duration: 30m
---

# Lab: Cilium Architecture Capstone

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-020/capstone/labs/lab-01
astrona submit -c sections/section-020/capstone/labs/lab-01
astrona destroy ats-052-lab-020-cap
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-policy-unchanged-and-shuttle-allowed.sh` | The policy is unchanged and shuttle reaches probe |
| `validate-drifter-blocked.sh` | drifter cannot reach probe |
| `validate-evidence-shuttle-identity.sh` | The report holds the live identity of shuttle after the fix |
| `validate-evidence-probe-identity.sh` | The report holds the live identity of probe |
| `validate-evidence-shuttle-endpoint-id.sh` | The report holds the live endpoint ID of shuttle |
