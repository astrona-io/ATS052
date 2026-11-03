---
draft: true
exam_objectives:
- Datapath Models
---
# Overlay Routing

A datapath model is the way pod packets travel between nodes. Cilium supports two main models. In the overlay model, the packet of a pod is wrapped in another packet that the node network can carry. In the native routing model, the pod packet travels as it is. This module covers the overlay model: what it does to a packet, which protocols exist and what it costs.

Keep one sentence in mind: **an overlay hides pod addresses from the node network by wrapping each packet, and the wrapping costs bytes of every packet.**

The module has two parts. The first part explains encapsulation and the overlay datapath. The second part covers the two tunnel protocols, the packet overhead and the effect on the maximum packet size.

## Learning objectives

After this module you can:

- Explain encapsulation and why an overlay needs no knowledge of pod addresses in the node network.
- Describe the path of a packet between pods on two nodes in tunnel mode.
- Name the two tunnel protocols and their default ports.
- Calculate the effect of encapsulation overhead on the pod MTU.
- Read the routing settings of a cluster and find the nodes of two pods.

## Before you start

You need Kubernetes basics and an idea of IP routing: addresses, routes and the difference between a node address and a pod address.

Your playground is a two-node kind cluster with Cilium 1.20.2 in tunnel mode with VXLAN. The pod CIDRs of the nodes are not known to the network under the nodes.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
