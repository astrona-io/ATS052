# Overview: The Operator And The CNI Plugin (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-040-02)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

The Deployment `cilium-operator` in `kube-system` runs one replica.


## Practice tasks

- Read `kubectl -n kube-system get deployment cilium-operator -o yaml` and find the host network setting, the ports and the affinity rule.
- Scale the operator to 2 replicas and list which pod holds the leader lease (`kubectl -n kube-system get lease`).
- Scale the operator to 0 and create a new pod. Observe what still works and what does not.
- Run `kubectl -n kube-system logs deploy/cilium-operator` and read the first lines.
