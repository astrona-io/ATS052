---
estimated_duration: 30m
---

# Lab: Datapath Models Capstone

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-050/capstone/labs/lab-01
astrona submit -c sections/section-050/capstone/labs/lab-01
astrona destroy ats-052-lab-050-cap
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-native-routing-with-direct-routes.sh` | Routing stays native and direct node routes are enabled |
| `validate-cross-node-request-works.sh` | shuttle reaches probe across nodes |
| `validate-evidence-routing.sh` | The report holds the live routing settings |
| `validate-evidence-nodes.sh` | The report names the nodes of probe and shuttle |
