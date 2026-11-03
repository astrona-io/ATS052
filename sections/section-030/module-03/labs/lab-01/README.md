---
estimated_duration: 25m
---

# Lab: Select A Pod IP Pool For A Namespace

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-030/module-03/labs/lab-01
astrona submit -c sections/section-030/module-03/labs/lab-01
astrona destroy ats-052-lab-030-03-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-namespace-annotated.sh` | The namespace outpost selects the pool green |
| `validate-drifter-uses-green-pool.sh` | The running drifter pod has an address from 10.20.0.0/16 |
| `validate-starfleet-stays-on-default.sh` | The shuttle pod still uses the default pool and the pools are unchanged |
