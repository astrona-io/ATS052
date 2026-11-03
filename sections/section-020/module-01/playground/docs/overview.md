# Overview: Desired State And Realised Identity (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-020-01)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Pod `drifter` | A client pod with `curl`, in another namespace |

The CiliumNetworkPolicy `probe-from-clients` allows ingress to `probe` only from pods labelled `role: client`. `shuttle` has no such label.


## Practice tasks

- Read `kubectl -n starfleet get ciliumendpoint shuttle -o yaml` and find `status.identity`, `status.networking` and `status.state`.
- Label `shuttle` with `role=client`, read the identity again, and compare the numbers. Remove the label and watch the identity change back.
- Run `kubectl get ciliumidentities` and find the identities that belong to `app=probe` and `app=shuttle`.
- Label `drifter` with `role=client` and test the request. Explain why it still fails.
