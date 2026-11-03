---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Summary

IP address management decides which pod gets which address. Cilium gives each node its own range and lets the agent on that node hand out single addresses from it, so the agents need no coordination when a pod starts and other nodes need only one route per node.

## What you learned

In cluster-pool mode the Cilium operator cuts pool CIDRs into slices of a fixed mask size and writes one slice into the `CiliumNode` object of each node. Three settings control this: the mode `ipam`, the pool list `cluster-pool-ipv4-cidr` and the slice size `cluster-pool-ipv4-mask-size`. The pool size and the mask size together decide the number of nodes and the number of pods per node. A pool that is exhausted leaves new nodes without a range.

Other modes move the ownership. In kubernetes mode the controller manager sets the range of each node. In crd mode an external component writes it. The cloud modes take addresses from the provider network through its API. Multi-pool keeps several pools and selects one per workload. The Kubernetes field `spec.podCIDR` of a node is not a reliable source of the real pod range, because Cilium uses it only in kubernetes mode.

- The operator owns the ranges in cluster-pool and multi-pool.
- The agent allocates single addresses from the node range.
- Read `ipam` and the pool settings in `cilium-config` for the mode.
- Pick the mode before installation, because a later change is a migration.

<!-- astrona:playground:destroy -->
