---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# IPAM Modes And Cluster Pool

Every pod needs an IP address, and someone must decide which address each pod gets. That task is called IP address management (IPAM). If two nodes hand out the same address, traffic goes to the wrong pod. If a node runs out of addresses, new pods cannot start. Cilium offers several IPAM modes, and each one splits the work between Cilium and the rest of the cluster in a different way.

Keep one sentence in mind: **a mode decides who owns the address ranges, and the agent hands out single addresses from the range of its node.** You will read the IPAM settings of a running cluster, see which range each node received, and compare the modes that Cilium supports.

The module has two parts. The first part explains the cluster-pool mode in detail. The second part compares it with the other modes and shows what to consider when you choose one.

## Learning objectives

After this module you can:

- Explain what IPAM does and why each node needs its own address range.
- Describe the cluster-pool mode and the settings that control it.
- Calculate how many node ranges a pool can provide.
- Name the other Cilium IPAM modes and say who owns the ranges in each.
- Read the IPAM mode and pool settings from a live cluster.

## Before you start

You need Kubernetes basics and some knowledge of IP subnets and CIDR notation. A CIDR block such as `10.100.0.0/16` describes an address range by its first address and the number of fixed leading bits.

Your playground is a two-node kind cluster with Cilium 1.20.2 in cluster-pool mode. The pool is `10.100.0.0/16` and each node receives a `/24` slice.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
