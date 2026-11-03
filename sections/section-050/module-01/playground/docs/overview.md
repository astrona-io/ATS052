# Overview: Overlay Routing With VXLAN (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-050-01)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

`probe` runs on the worker node and `shuttle` runs on the control-plane node, so every request between them crosses the node network.


## Practice tasks

- Read `routing-mode`, `tunnel-protocol` and any `tunnel` keys in `cilium-config`.
- In an agent pod run `ip -d link show cilium_vxlan` with `kubectl -n kube-system exec <pod> -c cilium-agent -- ip -d link show cilium_vxlan` and read the VXLAN id and port.
- Run `cilium-dbg status` and find the line about the routing mode.
- Compare the MTU of the node interface and of a pod interface (`ip link` in an agent pod and in `shuttle`).
