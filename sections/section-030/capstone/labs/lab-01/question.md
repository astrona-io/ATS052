---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# IPAM Capstone

Solve this question on: `terminal`

The `probe` Deployment in `starfleet` must move to its own address range, 10.30.0.0/16, without any change to the cluster installation. The `shuttle` pod must keep its current address range and must still reach `probe`.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-cap)"
```

1. Create a CiliumPodIPPool named `amber` with the IPv4 CIDR `10.30.0.0/16` and a mask size of 24.
2. Make the `probe` Deployment use the pool `amber` for its pods by annotating the pod template. The Deployment must roll out again so that all pods have addresses from `amber`.
3. `shuttle` must still have an address from the pool `default`, and a request from `shuttle` to `http://probe.starfleet:9898/healthz` must return 200.
