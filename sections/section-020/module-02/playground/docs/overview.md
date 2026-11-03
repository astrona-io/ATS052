# Overview: Endpoints, Identities And Datapath State (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-020-02)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |


## Practice tasks

- Read the CiliumEndpoint of `probe`, `shuttle` and `drifter`. List their endpoint IDs and identities side by side.
- Run `kubectl get ciliumnodes -o wide` and read the `spec.addresses` of one node.
- Pick the Cilium agent pod on the node of `probe` and run `kubectl -n kube-system exec <pod> -c cilium-agent -- cilium-dbg endpoint list`. Match its rows to the CiliumEndpoint objects.
- Run `cilium-dbg bpf endpoint list` and `cilium-dbg bpf ipcache list` in the same pod. Find the IP address of `probe` in both lists.
