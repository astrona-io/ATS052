---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Trace A Pod Address To Its Node Allocation

Solve this question on: `terminal`

An engineer must prove that the `probe` pod got its address from the slice that Cilium allocated to the node it runs on. In `cluster-pool` mode, the Cilium operator writes each node slice into the CiliumNode object of that node.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-02-01)"
```

Create the ConfigMap `address-evidence` in the namespace `starfleet` with these keys, for the pod with the label `app=probe`:

1. `probe-ip`: the IP address of the pod.
2. `probe-node`: the name of the node the pod runs on.
3. `node-cidr`: the first entry of `spec.ipam.podCIDRs` in the CiliumNode of that node.

The grader recomputes all three values from the live cluster. Do not delete or restart the pod.
