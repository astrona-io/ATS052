---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# From Node Range To Pod Address

A pod address has a path: the pool is cut into node ranges, one range goes to a node, and the agent of that node hands out one address to the pod. When a pod has the wrong address, or none, the cause lies somewhere on this path. This module teaches how to follow the path from the pod back to the pool and how to read the objects that record each step.

Keep one sentence in mind: **a pod address belongs to the range of the node that runs the pod, and the `CiliumNode` object records that range.** You will find the range of a node, check that a pod address lies inside it, and see what the agent reserves for itself.

The module has two parts. The first part describes how the operator allocates and records node ranges. The second part describes how the agent assigns single addresses and how to check an allocation.

## Learning objectives

After this module you can:

- Describe how the operator allocates a range to a node.
- Read the range of a node from the `CiliumNode` object.
- Check that a pod address lies inside the range of its node.
- Explain which addresses the agent keeps for itself.
- Identify the reason for a pod that has no address.

## Before you start

You need Kubernetes basics, CIDR notation and `kubectl get -o jsonpath`.

Your playground is a two-node kind cluster with Cilium 1.20.2 in cluster-pool mode with the pool `10.100.0.0/16` and a mask size of 24.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
