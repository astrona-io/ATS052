# Overview: Cluster-Pool Allocation In Practice (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-030-02)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |


## Practice tasks

- Compare `kubectl get ciliumnodes -o yaml` for both nodes. Find `spec.ipam.podCIDRs` and the `status.ipam` section.
- Scale `probe` to 20 replicas and check that every pod IP lies in the CIDR of its node (`kubectl get pods -o wide` and `kubectl get ciliumnodes`).
- Run `kubectl -n kube-system logs deploy/cilium-operator` and look for lines about node allocation.
- Delete one pod and check whether its replacement gets the same IP address.
