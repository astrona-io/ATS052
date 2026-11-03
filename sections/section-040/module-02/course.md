---
draft: true
exam_objectives:
- Cilium Component Roles
---
# The Operator And The CNI Plugin

Two Cilium components stay out of the path of packets but are still essential. The operator does tasks that need one cluster-wide view, and the CNI plugin is the small program that the container runtime calls when a pod starts. Knowing what each one does tells you what fails when one of them is missing, and that knowledge is worth a lot in an incident.

Keep one sentence in mind: **the operator keeps the cluster consistent and the CNI plugin connects new pods, and neither one forwards packets.**

The module has two parts. The first part describes the tasks of the operator and how to run it with more than one replica. The second part follows the CNI plugin from its installation to the call that creates the network of a pod.

## Learning objectives

After this module you can:

- List the tasks of the Cilium operator.
- Explain how operator leader election works and why two replicas improve availability.
- Say which functions continue and which stop when the operator is down.
- Describe how the CNI binary and its configuration get onto a node.
- Explain what happens to a new pod when the agent is not ready.

## Before you start

You need Kubernetes basics: Deployments, leader election with Lease objects and node scheduling.

Your playground is a two-node kind cluster with Cilium 1.20.2. The operator runs as the Deployment `cilium-operator` in `kube-system` with one replica.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
