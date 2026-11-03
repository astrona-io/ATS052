---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Record What Cilium Runs On The Cluster

Solve this question on: `terminal`

The `starfleet` namespace and the `outpost` namespace are running on a cluster that uses Cilium as its network plugin. The platform team wants a short report of what Cilium runs and how it sees the `drifter` workload in `outpost`. Read the values from the live cluster. Do not guess them.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-01-01)"
```

Create the ConfigMap `cni-evidence` in the namespace `starfleet` with these three keys:

1. `agent-image`: the container image of the container `cilium-agent` in the DaemonSet `cilium` in `kube-system`.
2. `ready-agents`: the number of Cilium agent pods that are ready, taken from the status of that DaemonSet.
3. `drifter-identity`: the numeric security identity that Cilium assigned to the Pod `drifter` in `outpost`. Cilium stores it in the CiliumEndpoint object with the same name and namespace as the Pod.

The grader reads the same values from the live API and compares them with your ConfigMap. Do not change any Cilium object or any workload.
