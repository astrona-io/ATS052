---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# IP Address Management (IPAM) with Cilium

This section explains how pods get their IP addresses. It covers cluster-pool IPAM, the other IPAM modes and how to choose between them, how the operator allocates ranges to nodes, how the agent assigns addresses and how multi-pool IPAM selects a pool for a workload.

Each module has a landing page, two reading parts and a summary. The readings are written for the exam domain and use a private playground for hands-on steps. Each module has one graded lab, and the section ends with a capstone lab and a knowledge check.

## Modules

**IPAM Modes And Cluster Pool**

- Explain what IPAM does and why each node needs its own address range.
- Describe the cluster-pool mode and the settings that control it.
- Calculate how many node ranges a pool can provide.
- Name the other Cilium IPAM modes and say who owns the ranges in each.
- Read the IPAM mode and pool settings from a live cluster.

**From Node Range To Pod Address**

- Describe how the operator allocates a range to a node.
- Read the range of a node from the `CiliumNode` object.
- Check that a pod address lies inside the range of its node.
- Explain which addresses the agent keeps for itself.
- Identify the reason for a pod that has no address.

**Multi-Pool IPAM**

- Describe a `CiliumPodIPPool` and its fields.
- Select a pool for a pod or for a namespace with the annotation.
- Explain how the operator and the agent share pool ranges between nodes.
- Explain why an annotation change does not move running pods.
- Name the requirements that multi-pool mode has for routing.

## Labs and quiz

The labs are marked UNTESTED: they passed static checks and have not been run. The capstone lab combines the skills of the section. The quiz has single-choice questions and a pass score of 70 percent.
