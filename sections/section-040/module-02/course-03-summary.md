---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Summary

The operator and the CNI plugin stay out of the path of packets, but each one has a job that no other component can do.

## What you learned

The operator is a Deployment on the host network. It registers the Cilium custom resources, allocates address ranges to nodes in some IPAM modes, and removes stale `CiliumNode`, `CiliumIdentity` and `CiliumEndpoint` objects. Several replicas use a Lease for leader election, so one replica works and the others wait. The replicas need separate nodes, because of the host network and the anti-affinity rule. When the operator is down, existing traffic, policy and running pods continue. New nodes get no range and stale objects stay until it returns.

The CNI plugin is the small binary `cilium-cni`. The agent copies it and its configuration to the node. At pod start the runtime calls it with `ADD`, and it asks the agent to allocate the address, create the interface and build the endpoint. At pod deletion it calls `DEL`, and the agent releases the address and removes the endpoint. Failures at this point show as pods in `ContainerCreating`, while running pods continue. The pod events name the failing link: a missing file, an unready agent or an exhausted range.

- The operator does cluster-wide tasks and never forwards packets.
- Operator replicas elect a leader through a Lease.
- The CNI call happens at pod start and stop only.
- A missing agent blocks new pods, and not running pods.

<!-- astrona:playground:destroy -->
