---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# The Role Of Cilium In Kubernetes Networking

Kubernetes decides which pods run and where they run, but it does not move a single network packet. A separate component, the network plugin, gives each pod an IP address and connects it to the rest of the cluster. Cilium is such a plugin. This module explains what a network plugin must do, what the Container Network Interface (CNI) standard defines, and which parts of Cilium do the work on a cluster.

Keep one sentence in mind: **Kubernetes states the network rules, and the network plugin makes them true on every node.** You will find the Cilium components on a running cluster, read the identity that Cilium gives to a workload, and see where the kernel enters the picture.

The module has two parts. The first part follows the steps that happen when the kubelet starts a pod and shows which Cilium component answers each step. The second part explains eBPF, the Linux kernel feature that Cilium uses to forward packets and to enforce policy.

## Learning objectives

After this module you can:

- State the three rules of the Kubernetes network model.
- Explain what the CNI standard asks a network plugin to do when a pod starts and when it stops.
- Name the Cilium components, where each one runs and what each one does.
- Explain what eBPF is and why Cilium uses it instead of long lists of iptables rules.
- Read the Cilium agent image, the number of ready agents and the security identity of a workload from a live cluster.

## Before you start

You need Kubernetes basics: pods, Deployments, Services, namespaces and the commands `kubectl get` and `kubectl describe`.

Your playground is a two-node kind cluster running Kubernetes 1.35 with Cilium 1.20.2 as the network plugin. A Service is a stable virtual address that forwards to a set of pods.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

`kubectl` already points at the playground cluster. Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
