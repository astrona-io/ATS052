---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Run The Operator In High Availability

Solve this question on: `terminal`

The Cilium operator does cluster-wide work such as IPAM and garbage collection. With one replica, a node failure stops that work. The platform team wants two replicas. The operator pods use the host network and listen on fixed ports, so two replicas cannot share one node.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-02-01)"
```

1. Scale the Deployment `cilium-operator` in `kube-system` to 2 replicas and wait until both are available.
2. Check that the two operator pods run on different nodes.
3. Create the ConfigMap `component-evidence` in the namespace `starfleet` with the keys `operator-image` (the image of the container `cilium-operator`) and `ciliumnode-count` (the number of CiliumNode objects in the cluster).
