---
estimated_duration: 25m
---

# Lab: Run The Operator In High Availability

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-040/module-02/labs/lab-01
astrona submit -c sections/section-040/module-02/labs/lab-01
astrona destroy ats-052-lab-040-02-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-operator-has-two-ready-replicas.sh` | The operator Deployment has two available replicas |
| `validate-operator-pods-on-different-nodes.sh` | The two operator pods run on different nodes |
| `validate-operator-image-recorded.sh` | The report holds the live operator image |
| `validate-ciliumnode-count-recorded.sh` | The report holds the live number of CiliumNode objects |
