---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Restore Hubble Relay And Read Its Service

Solve this question on: `terminal`

Each Cilium agent runs a Hubble server that records the network flows of its node. Hubble Relay connects to all of those servers and gives one cluster-wide API. The relay Deployment in `kube-system` has been scaled to zero, so no client can read cluster-wide flows.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-03-01)"
```

1. Bring the Deployment `hubble-relay` in `kube-system` back to 1 replica and wait until it is available.
2. Check that the Service `hubble-relay` has an endpoint.
3. Create the ConfigMap `hubble-evidence` in the namespace `starfleet` with the keys `relay-service-port` (the first port of the Service `hubble-relay`) and `peer-service-port` (the first port of the Service `hubble-peer` in `kube-system`).
