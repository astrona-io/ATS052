---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Multi-Pool IPAM

One address pool for the whole cluster is simple, but it does not fit every environment. A team may own its own address range, an edge firewall may allow only one range to reach a database, or an application may need addresses from a separate network. Multi-pool IPAM lets a cluster hold several pools and lets each workload choose its pool.

Keep one sentence in mind: **a pool is a named address range, and an annotation on a pod or a namespace chooses the pool when the pod is created.** You will read the pools of a cluster, create a new one, select it with an annotation and learn why running pods do not change.

The module has two parts. The first part explains pools and the annotation that selects them. The second part covers the requirements, the limits and the steps to move existing workloads to another pool.

## Learning objectives

After this module you can:

- Describe a `CiliumPodIPPool` and its fields.
- Select a pool for a pod or for a namespace with the annotation.
- Explain how the operator and the agent share pool ranges between nodes.
- Explain why an annotation change does not move running pods.
- Name the requirements that multi-pool mode has for routing.

## Before you start

You need the knowledge from the other IPAM material: node ranges, `CiliumNode` and CIDR notation. You also need `kubectl annotate` and `kubectl rollout restart`.

Your playground is a two-node kind cluster with Cilium 1.20.2 in multi-pool mode with native routing. Two pools exist: `default` with `10.10.0.0/16` and `green` with `10.20.0.0/16`, each cut into `/24` slices.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
