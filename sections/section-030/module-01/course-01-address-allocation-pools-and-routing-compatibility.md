---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Address Allocation, Pools And Routing Compatibility

IP Address Management allocates addresses to workload endpoints. It answers which address a Pod may use and which authority manages the pool. It does not independently guarantee that other nodes, external networks or permitted peers can reach that address. IPAM and routing must fit the same deployment design.

## Select The Allocation Authority

Cilium supports several IPAM models for different environments. In Kubernetes host-scope mode, Kubernetes supplies node PodCIDRs and the node uses its assigned range. In Cilium cluster-pool mode, Cilium's allocation machinery manages node ranges from configured pools. Other modes can provide more flexible pools or integrate with a cloud provider's address and interface model.

The selection affects which component owns allocation and what evidence explains an exhausted range. A setting named pool does not imply that every mode uses the same allocator or lifecycle. Identify the active mode before deciding which component should have produced a missing address.

## Capacity Exists At Multiple Levels

A large cluster pool can still assign a node range with limited capacity. A node may exhaust its local allocation even when unused ranges remain elsewhere. Cloud-integrated modes can also depend on interface attachment limits, provider API availability and subnet capacity. Those constraints are separate from CPU or memory scheduling capacity.

A Pod waiting for networking can therefore reflect allocation failure rather than an application error. Compare the requested endpoint, node allocation and responsible controller state. A healthy existing Pod does not establish that the node has capacity for another endpoint.

## Keep Address Spaces Compatible

Pod, Service, node and external network ranges must be planned to avoid unintended overlap. If a remote destination has the same prefix as a locally interpreted workload range, the host may choose the wrong route. Address identity also matters in multi-cluster designs, where supported non-overlapping ranges and unique cluster identities help preserve reachability and attribution.

The selected routing model determines how infrastructure learns or carries workload addresses. An overlay can encapsulate traffic between nodes, while native routing requires appropriate underlay reachability. IPAM allocating an address from a valid pool does not install every required route in an external router.

## Lifecycle And Reuse Need Ownership

Allocation should follow endpoint creation and deletion under the implementation's supported lifecycle. Stale allocations can waste capacity, while unsafe reuse can create attribution confusion if old observations are interpreted as current workload identity. Use the endpoint lifecycle and durable identifiers alongside addresses when investigating incidents or connectivity changes.

Pool expansion and allocation-mode changes are not arbitrary interchangeable edits. A mode can have constraints on changing ranges, masks or ownership while workloads are active. Review the documented migration procedure and compatibility of existing addresses before proposing a change. A configuration value accepted by Helm does not prove a live migration is safe or complete.

## Diagnose The Responsible Stage

If a new workload has no usable network, ask whether scheduling occurred, the CNI lifecycle reached the agent, allocation succeeded and endpoint programming completed. If it has an address but cannot communicate, investigate routing, policy and destination behavior separately. Keeping the stages distinct avoids deleting workloads repeatedly when the actual issue is a depleted pool or unavailable allocation dependency.

## Common pitfalls

> [!WARNING]
> Address allocation is not route reachability. Identify the active IPAM authority and all capacity constraints, and do not treat a live mode change as a universally supported migration.
