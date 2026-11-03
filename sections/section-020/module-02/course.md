---
draft: true
exam_objectives:
- Cilium Architecture
---
# Endpoints And The State Of The Datapath

Behind every pod that Cilium manages sits an endpoint, which is the object the agent uses to attach programs, assign an identity and track policy. When something goes wrong with a workload, the endpoint is where the agent records what it knows. This module teaches what an endpoint is, how its state changes, and how to compare what the cluster says with what the kernel holds.

Keep one sentence in mind: **the API objects state the intent, and the endpoint and its maps show what is really in effect.** You will read the fields of a `CiliumEndpoint`, follow the endpoint states, and use agent commands to look into the kernel maps.

The module has two parts. The first part explains endpoints, their numbers and their lifecycle. The second part shows how to read desired and realised state and how to find dropped traffic.

## Learning objectives

After this module you can:

- Explain what a Cilium endpoint is and how it relates to a pod and a CiliumEndpoint object.
- Read the endpoint ID, the identity and the state from a CiliumEndpoint.
- Name the main endpoint states and what causes a regeneration.
- Use `cilium-dbg` to inspect endpoints, identities and policy maps.
- Find dropped packets with the monitor command.

## Before you start

You need Kubernetes basics and some comfort with running commands inside a pod with `kubectl exec`.

Your playground is a two-node kind cluster with Cilium 1.20.2.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
