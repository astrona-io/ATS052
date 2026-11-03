---
draft: true
exam_objectives:
- Datapath Models
---
# Native Routing

In native routing mode, pod packets leave a node without any wrapping. They are routed like any other IP packet, which saves the overhead of an overlay and keeps the packets visible to the network. The price is that the network must know how to reach every pod range. This module explains what that requires and how Cilium and the network can fulfil it.

Keep one sentence in mind: **native routing removes the wrapping, and in return something must tell every node and router where each pod range lives.**

The module has two parts. The first part lists the requirements of native routing and the settings that select it. The second part explains the ways to distribute routes, the use of masquerading and the typical failures.

## Learning objectives

After this module you can:

- State what native routing requires from the network.
- Name the settings that select native routing and what each one means.
- Explain what `auto-direct-node-routes` does and when it works.
- Describe the alternatives for route distribution such as BGP and cloud routes.
- Explain masquerading and which destinations it applies to.

## Before you start

You need Kubernetes basics and an idea of IP routing: routes, next hops and subnets.

Your playground is a two-node kind cluster with Cilium 1.20.2 in native routing mode. Both nodes share one layer 2 network.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
