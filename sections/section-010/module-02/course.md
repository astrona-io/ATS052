---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Where Cilium Acts: Services, Pods And Policy

When a request fails in a Kubernetes cluster, three different mechanisms can be responsible: the Service that selects backends, the network path between pods, and the policy that allows or denies the traffic. Each mechanism has its own owner and its own objects. A good operator finds the failing one quickly, and this module teaches how to do that for a cluster that uses Cilium.

Keep one sentence in mind: **a Service chooses which pods receive traffic, the datapath moves the packet, and policy decides whether the packet is allowed.** You will read the objects that belong to each step, break and repair a Service selector, and write a CiliumNetworkPolicy that restricts access to a workload.

The module has two parts. The first part follows a request from a client pod to a Service and shows where selection and translation happen. The second part explains how Cilium policy selects workloads, which traffic it allows, and how it differs from the standard Kubernetes NetworkPolicy.

## Learning objectives

After this module you can:

- Explain how a Service selector produces the endpoints that receive traffic.
- Describe how Cilium translates a Service address to a pod address.
- Tell a Service fault apart from a policy fault by reading the right objects.
- Write a CiliumNetworkPolicy that allows one port from one namespace.
- Explain why selecting a pod with a policy changes its default behaviour.

## Before you start

You need Kubernetes basics: labels, selectors, Services and namespaces, plus the commands `kubectl get`, `kubectl apply` and `kubectl exec`.

Your playground is a two-node kind cluster with Cilium 1.20.2.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` (two pods) and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

No policy exists at the start, so every pod can reach every other pod. Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
