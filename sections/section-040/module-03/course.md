---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Hubble And Hubble Relay

Policy and routing problems are easier to solve when you can see the traffic. Hubble is the observability part of Cilium. It records flows, which are records of connections and packets with identities and verdicts, and it makes them available to commands, a user interface and metrics. This module explains where Hubble runs, how its data travels and what you need to switch on to read flows from the whole cluster.

Keep one sentence in mind: **each agent records the flows of its node, and Hubble Relay combines them into one cluster-wide view.**

The module has two parts. The first part explains the Hubble server in the agent and what a flow contains. The second part explains Hubble Relay, the peer service and the user interface, and how a client connects.

## Learning objectives

After this module you can:

- Describe what a Hubble flow contains.
- Explain where the Hubble server runs and what limits how many flows it keeps.
- Describe how Hubble Relay finds the agents and what it exposes.
- Name the Services that clients use and what each one is for.
- Restore a stopped Hubble Relay and check its Service.

## Before you start

You need Kubernetes basics: Services, Endpoints and port forwarding with `kubectl port-forward`.

Your playground is a two-node kind cluster with Cilium 1.20.2. Hubble is enabled in the agents and Hubble Relay is installed, but the Deployment `hubble-relay` starts with zero replicas.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
