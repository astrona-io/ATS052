---
estimated_duration: 20m
---

# Lab: Read Endpoint State From Cilium Objects

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-020/module-02/labs/lab-01
astrona submit -c sections/section-020/module-02/labs/lab-01
astrona destroy ats-052-lab-020-02-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-endpoint-id-recorded.sh` | The report holds the live endpoint ID of probe |
| `validate-identity-recorded.sh` | The report holds the live identity of probe |
| `validate-state-recorded.sh` | The report holds the live endpoint state of probe |
