---
estimated_duration: 25m
---

# Lab: Separate Service Selection From Policy

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-010/module-02/labs/lab-01
astrona submit -c sections/section-010/module-02/labs/lab-01
astrona destroy ats-052-lab-010-02-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-service-has-backends.sh` | The Service probe selects the probe pods and has endpoints |
| `validate-policy-is-cilium-policy.sh` | A CiliumNetworkPolicy probe-ingress protects the probe pods on port 9898 |
| `validate-shuttle-reaches-probe.sh` | shuttle receives HTTP 200 from the probe Service |
| `validate-drifter-is-blocked.sh` | drifter cannot reach the probe Service |
