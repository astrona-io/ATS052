---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Summary

A pod address has a clear path from pool to pod. The pool is cut into node ranges by the operator, the range of each node is recorded in its `CiliumNode`, and the agent on the node hands out one address per pod from that range.

## What you learned

When a node joins, its agent creates a `CiliumNode` without a range. The operator writes a free slice into `spec.ipam.podCIDRs`, and the agent starts to allocate from it. Until then, pods on the node cannot start. The operator rebuilds its view from the existing `CiliumNode` objects after a restart, so allocations survive it, and nodes that already have a range keep running while the operator is down.

The agent allocates from a local allocator, so starting a pod needs no remote call. It keeps some addresses of the slice for its own interfaces, so the usable number is smaller than the size of the slice. A pod address must lie in the slice of the node that runs the pod, and addresses are reused after a pod is deleted, so an address does not identify a workload for long.

The right place to read a range is `spec.ipam.podCIDRs` of the `CiliumNode`. The `spec.podCIDR` field of the Kubernetes node is not the source of truth in cluster-pool mode.

- The operator owns the range, and the agent owns the single addresses.
- A node without a range cannot start pods.
- Check the address against the slice of the node that runs the pod.
- Do not edit `spec.ipam.podCIDRs` by hand.

<!-- astrona:playground:destroy -->
