# Overview: Native Routing (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-050-02)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

`probe` runs on the worker node and `shuttle` runs on the control-plane node, so every request between them crosses the node network.

The setting `auto-direct-node-routes` is `"false"` on purpose.


## Practice tasks

- Request `http://probe.starfleet:9898/healthz` from `shuttle` before any change and note the result.
- In an agent pod, run `kubectl -n kube-system exec <pod> -c cilium-agent -- ip route` and look for routes to the pod CIDR of the other node. Enable `auto-direct-node-routes`, restart the agents and run the command again.
- Read the pod CIDR of each node with `kubectl get nodes -o custom-columns=NAME:.metadata.name,CIDR:.spec.podCIDR`.
- Run `cilium-dbg status` and read the routing line.
