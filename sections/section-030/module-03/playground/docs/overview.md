# Overview: Multi-Pool IPAM (Playground)

This is a playground, not a lab. It starts a fresh two-node kind cluster (Kubernetes v1.35.0) with Cilium 1.20.2 as the network plugin, creates the example workloads, and waits. There is no task, no `astrona submit` and no pass or fail.

Connect to it first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-playground-030-03)"
```

## What is in the cluster

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server (podinfo) on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl`, in the same namespace as `probe` |
| `outpost` | Deployment `drifter` | A client pod with `curl`, in another namespace |

Cilium runs in `multi-pool` mode with native routing. The pools are `default` (10.10.0.0/16) and `green` (10.20.0.0/16).


## Practice tasks

- Run `kubectl get ciliumpodippools -o yaml` and read `spec.ipv4.cidrs` and `spec.ipv4.maskSize`.
- Read the `spec.ipam.pools` section of a CiliumNode to see the slices allocated per pool.
- Annotate one new pod with `ipam.cilium.io/ip-pool: green` and compare its address with a pod without the annotation.
- Create a third pool, annotate a namespace with its name, and find out what happens to a pod when the pool name does not exist.
