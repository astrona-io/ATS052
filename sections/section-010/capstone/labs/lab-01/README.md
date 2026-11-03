---
estimated_duration: 30m
---

# Lab: Role Of Cilium Capstone

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-010/capstone/labs/lab-01
astrona submit -c sections/section-010/capstone/labs/lab-01
astrona destroy ats-052-lab-010-cap
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-service-forwards-to-both-pods.sh` | The Service has two endpoint addresses |
| `validate-policy-allows-only-starfleet.sh` | shuttle reaches probe, drifter does not, through a CiliumNetworkPolicy |
| `validate-evidence-endpoint-count.sh` | The report holds the live endpoint count |
| `validate-evidence-probe-identity.sh` | The report holds the live identity of the probe pods |
| `validate-evidence-agents-ready.sh` | The report holds the live ready-agent count |
