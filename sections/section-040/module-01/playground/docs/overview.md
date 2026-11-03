# Overview: The Cilium Agent (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-040-01)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

The Cilium agent runs as the DaemonSet `cilium` in `kube-system`, one pod per node.


## Practice tasks

- List the agent pods with `kubectl -n kube-system get pods -l k8s-app=cilium -o wide` and read the containers and init containers of one pod with `kubectl -n kube-system describe pod <pod>`.
- Run `kubectl -n kube-system exec <agent pod> -c cilium-agent -- cilium-dbg status` and read each section of the output.
- Run `cilium-dbg endpoint list` and `cilium-dbg config` in the same pod.
- Delete one agent pod and watch `kubectl get pods -w`. Keep a request loop running from `shuttle` to `probe` and note whether existing connections continue.
