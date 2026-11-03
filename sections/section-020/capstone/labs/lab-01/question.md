---
draft: true
exam_objectives:
- Cilium Architecture
---
# Cilium Architecture Capstone

Solve this question on: `terminal`

The CiliumNetworkPolicy `probe-from-clients` in `starfleet` lets only pods labelled `role: client` reach the `probe` pods on port 9898. The `shuttle` pod needs access. Afterwards the team wants a record of how Cilium realised the change.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-cap)"
```

1. Give `shuttle` access without editing or deleting the policy.
2. Create the ConfigMap `identity-evidence` in `starfleet` with these keys, read after the fix: `shuttle-identity`, the numeric security identity of `shuttle`; `probe-identity`, the numeric security identity of the `probe` pod; `shuttle-endpoint-id`, the endpoint ID of `shuttle`.
3. A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return 200 and the same request from `drifter` must fail.

The grader reads live values. A value taken before the fix does not match.
