# Overview: Cilium As The Cluster Network Plugin (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-010-01)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |


## Practice tasks

- List the Cilium pods with `kubectl -n kube-system get pods -l k8s-app=cilium -o wide` and match each pod to a node.
- Read the CiliumEndpoint of `shuttle` and of `drifter`. Compare their `status.identity.id` values and their `status.identity.labels`.
- List the custom resources Cilium registers with `kubectl get crd | grep cilium`.
- Delete the `shuttle` pod, create it again, and watch the CiliumEndpoint object disappear and come back.
