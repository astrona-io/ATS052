---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Select A Pod IP Pool For A Namespace

Solve this question on: `terminal`

This cluster uses Cilium multi-pool IPAM. The pool `default` serves 10.10.0.0/16 and the pool `green` serves 10.20.0.0/16. The team that owns `outpost` has an address range in the `green` network. Every pod in `outpost` must get its address from the pool `green`. Pods in `starfleet` must keep using `default`.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-03-01)"
```

1. Make new pods in the namespace `outpost` take their address from the pool `green`. Use a namespace annotation, not a per-pod annotation.
2. Make the existing `drifter` pod pick up the change. The Deployment is `drifter` in `outpost`.
3. Do not change the pools and do not move any pod in `starfleet`.

The grader checks the annotation, the address of the running `drifter` pod and the address of `shuttle`.
