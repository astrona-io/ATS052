# Overview: Service Selection And Policy Failures (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-010-02)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

The Service `probe` is broken on purpose: its selector is `app: probe-api`, but the pods carry `app: probe`.


## Practice tasks

- Run `kubectl -n starfleet get endpoints probe` and explain why it is empty. Fix the Service and run it again.
- From `shuttle` and from `drifter`, request `http://probe.starfleet:9898/healthz`. Both must succeed before any policy exists.
- Write a CiliumNetworkPolicy that selects `app: probe`. Observe that a pod that matches no allow rule is now denied.
- Compare a request to the pod IP with a request to the Service name. Decide which of Service handling or policy produced each result.
