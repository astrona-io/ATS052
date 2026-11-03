---
estimated_duration: 25m
---

# Lab: Verify The Datapath Model Of A Cluster

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-050/module-03/labs/lab-01
astrona submit -c sections/section-050/module-03/labs/lab-01
astrona destroy ats-052-lab-050-03-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-model-keys-recorded-routing-mode.sh` | The report holds the live value of routing-mode |
| `validate-model-keys-recorded-ipv4-native-routing-cidr.sh` | The report holds the live value of ipv4-native-routing-cidr |
| `validate-model-keys-recorded-auto-direct-node-routes.sh` | The report holds the live value of auto-direct-node-routes |
| `validate-model-keys-recorded-kube-proxy-replacement.sh` | The report holds the live value of kube-proxy-replacement |
| `validate-model-keys-recorded-enable-bpf-masquerade.sh` | The report holds the live value of enable-bpf-masquerade |
| `validate-cross-node-request-works.sh` | shuttle reaches probe across nodes |
