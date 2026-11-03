---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Summary

Kubernetes defines what the network must provide: a unique IP address for every pod, NAT-free communication between pods, and node access to local pods. It leaves the implementation to a network plugin. The container runtime calls the plugin through the Container Network Interface when a pod starts and when it stops.

## What you learned

Cilium answers the CNI call with a small binary that forwards the request to the Cilium agent on the node. The agent allocates the address, creates a veth pair, moves one end into the pod network namespace and attaches kernel programs to the other end. The operator takes the tasks that need a cluster-wide view, and custom resources such as `CiliumNode`, `CiliumEndpoint` and `CiliumIdentity` store the shared state.

The programs are eBPF programs. The kernel verifier checks them before it runs them, and they keep state in hash-table maps. Because a map lookup does not grow with the number of entries, Cilium avoids the long sequential rule lists of iptables. Policy is matched on security identities, which are numbers that Cilium assigns to sets of labels, so a pod that restarts with a new address keeps its rules.

- A network plugin makes the Kubernetes network rules true on every node.
- The `cilium-cni` binary forwards `ADD` and `DEL` to the agent.
- The agent is a DaemonSet, and the operator is a Deployment.
- eBPF programs attach at tc hooks, device hooks and socket hooks.
- Every pod that Cilium manages has a CiliumEndpoint and a security identity.

<!-- astrona:playground:destroy -->
