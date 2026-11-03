---
draft: true
exam_objectives:
- Cilium Component Roles
---
# The Cilium Agent

The Cilium agent is the component that does the work on every node. It answers the CNI calls, allocates pod addresses from the node range, resolves identities, computes policy and loads the kernel programs. If you understand what the agent does and how it is configured, you can explain most behaviour of a Cilium cluster, and you can change that behaviour safely.

Keep one sentence in mind: **the agent reads its settings once at start, so a configuration change reaches a node only when its agent restarts.**

The module has two parts. The first part lists what the agent does on a node and how it is deployed. The second part explains its configuration, what a restart does to the traffic of running pods, and how to look into the agent when something fails.

## Learning objectives

After this module you can:

- Name the main tasks of the Cilium agent.
- Explain how the agent is deployed and why it needs elevated privileges.
- Describe where the agent reads its configuration and when it reads it.
- Explain what happens to running pods when the agent restarts.
- Read the status and the logs of an agent.

## Before you start

You need Kubernetes basics, in particular DaemonSets, ConfigMaps and `kubectl logs`.

Your playground is a two-node kind cluster with Cilium 1.20.2. The agent runs as the DaemonSet `cilium` in the namespace `kube-system`, with one pod per node, and the debug logging is switched off.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
