# Overview: Hubble And Hubble Relay (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-040-03)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

Hubble Relay is installed, but the Deployment `hubble-relay` starts at 0 replicas.


## Practice tasks

- Scale `hubble-relay` to 1 and run `kubectl -n kube-system port-forward service/hubble-relay 4245:80`. In another terminal, install or use the `hubble` command-line client and run `hubble status` against `localhost:4245`.
- Send requests from `shuttle` to `probe` in a loop and run `hubble observe --namespace starfleet`.
- Run `cilium-dbg hubble` style checks inside an agent pod only with commands that exist in the pod. Start with `cilium-dbg status`.
- Read the Services `hubble-relay` and `hubble-peer` and explain which component connects to which.
