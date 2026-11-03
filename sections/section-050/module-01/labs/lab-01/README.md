---
estimated_duration: 25m
---

# Lab: Record Overlay Routing Settings And Node Placement

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-050/module-01/labs/lab-01
astrona submit -c sections/section-050/module-01/labs/lab-01
astrona destroy ats-052-lab-050-01-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-routing-mode-recorded.sh` | The report holds the live routing mode |
| `validate-tunnel-protocol-recorded.sh` | The report holds the live tunnel protocol |
| `validate-node-placement-recorded.sh` | The report names the nodes of probe and shuttle |
| `validate-cross-node-request-works.sh` | shuttle reaches probe across nodes |
