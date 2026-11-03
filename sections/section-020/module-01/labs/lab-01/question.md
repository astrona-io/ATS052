---
draft: true
exam_objectives:
- Cilium Architecture
---
# Repair A Policy Through Pod Labels

Solve this question on: `terminal`

The CiliumNetworkPolicy `probe-from-clients` in `starfleet` allows requests to the `probe` pods on port 9898 only from pods that carry the label `role: client`. The `shuttle` pod is a legitimate client, but its requests time out. The policy is correct and must stay as it is.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-01-01)"
```

1. Find out why `shuttle` is denied. Compare the desired state (the policy and the pod labels) with the security identity that Cilium realised for `shuttle`.
2. Fix the cause without editing, replacing or deleting the CiliumNetworkPolicy.
3. A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200. The same request from `drifter` in `outpost` must keep failing.
