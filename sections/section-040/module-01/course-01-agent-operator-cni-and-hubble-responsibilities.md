---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Agent, Operator, CNI And Hubble Responsibilities

Cilium is a collection of cooperating components rather than one process with every networking responsibility. Component boundaries explain why an installation can have partial service: packets may flow while allocation stalls, or applications may communicate while the observability client cannot obtain records. Match the failed operation to its owner.

## Agent And Endpoint State

The Cilium agent runs on nodes and manages the local networking state for endpoints. It observes relevant orchestration changes, reconciles policy and Service information, and programs the datapath. A node-local endpoint problem can therefore require evidence from that node's agent even when cluster-wide resources look correct.

The agent's state includes desired and realized relationships. An update can be accepted upstream but not yet applied locally. A status from one node is not proof that every node has converged. Identify the affected workload and execution node before interpreting a local observation as a complete cluster result.

## Operator And Cluster Coordination

The operator handles duties that should be coordinated for the cluster, including allocation or cleanup responsibilities depending on mode. It is not in the ordinary critical path for every policy decision or packet forward. If it is temporarily unavailable, existing traffic can continue while new allocations or other managed work are delayed.

That does not mean operator availability is irrelevant. A mode that relies on operator allocation can stop preparing new workload networking when the dependency fails. Different configuration models create different consequences, so evaluate the active responsibility rather than assume one outage effect across all deployments.

## CNI Participates In Pod Lifecycle

The CNI integration is invoked through the runtime's Pod networking lifecycle. It coordinates with the local Cilium API to prepare or remove the required networking state. It does not replace the scheduler, which selects a node, or the application process, which serves requests. A scheduled Pod can still fail network preparation before its application starts.

Deleting and recreating a Pod may repeat the same failure if the CNI configuration, local agent or allocation dependency is still incorrect. Establish which lifecycle operation failed instead of treating replacement as an explanation.

## Hubble Has Observation Components

The Hubble server exposes observations from its local Cilium environment. Relay connects to available servers and offers an aggregated view. The Hubble CLI retrieves flow records, while the UI presents relationships and selected flow context. These components observe supported networking behavior rather than form the normal forwarding path for every application packet.

A Relay connectivity problem can leave node-local records available while the cluster-wide view is incomplete. A UI filter can also hide records that are present in the API. Distinguish collection, aggregation, access and presentation when investigating an empty view.

## Management Clients Use Different Paths

The remote Cilium CLI uses Kubernetes access and kubeconfig context to install, configure or inspect a cluster. The node-local cilium-dbg client interacts with local agent debugging interfaces and can inspect datapath state. They have different scope and permissions. A remote authentication failure is not evidence that the local agent stopped forwarding.

Review the requested operation, context, component and permissions together. Installation health, endpoint readiness and useful application communication remain separate observations. A good diagnosis preserves those boundaries and selects evidence from the component that owns the missing transition.

## Common pitfalls

> [!WARNING]
> The operator and Hubble Relay are not per-packet forwarding components. Remote CLI access and local agent debugging have different scopes, and one healthy node does not establish cluster-wide convergence.
