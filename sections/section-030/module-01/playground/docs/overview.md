# Overview: Cilium IPAM Modes (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-030-01)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

Cilium runs in `cluster-pool` mode with the pool `10.100.0.0/16` and a mask size of 24.


## Practice tasks

- Read the `ipam` keys in `cilium-config` and find which component each key configures.
- Run `kubectl get ciliumnodes -o custom-columns=NAME:.metadata.name,CIDRS:.spec.ipam.podCIDRs` and compare the result with `kubectl get nodes -o custom-columns=NAME:.metadata.name,CIDR:.spec.podCIDR`.
- List pod IP addresses with `kubectl get pods -A -o wide` and check that each one lies inside the podCIDR of its node.
- Scale `probe` to 5 replicas and see which node CIDR each new pod IP comes from.
