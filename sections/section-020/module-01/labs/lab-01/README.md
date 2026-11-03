---
estimated_duration: 25m
---

# Lab: Repair A Policy Through Pod Labels

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-020/module-01/labs/lab-01
astrona submit -c sections/section-020/module-01/labs/lab-01
astrona destroy ats-052-lab-020-01-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-shuttle-has-client-label.sh` | The shuttle pod carries the label role=client |
| `validate-policy-is-unchanged.sh` | The CiliumNetworkPolicy still selects role: client and port 9898 |
| `validate-shuttle-reaches-probe.sh` | shuttle receives HTTP 200 from the probe Service |
| `validate-drifter-stays-blocked.sh` | drifter still cannot reach probe |
