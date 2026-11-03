# Overview: Comparing Datapath Models (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-050-03)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

`probe` runs on the worker node and `shuttle` runs on the control-plane node, so every request between them crosses the node network.


## Practice tasks

- Print every `cilium-config` key that contains `route`, `tunnel`, `masquerade` or `proxy`.
- Run `cilium-dbg status` in an agent pod and read the lines for routing, masquerading and kube-proxy replacement.
- Run `ip route` and `iptables -t nat -S` in an agent pod (`-c cilium-agent`) and compare the output with the settings.
- Change a setting in a copy of the values, reinstall in a second playground, and compare which routes and devices appear.
