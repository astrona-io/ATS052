---
draft: true
exam_objectives:
- Datapath Models
---
# Fix Native Routing Between Nodes

Solve this question on: `terminal`

This cluster runs Cilium in native routing mode: pod packets leave a node without encapsulation, and the network under the nodes must know how to reach every pod CIDR. The two nodes share one layer 2 network. `shuttle` on the control-plane node cannot reach `probe` on the worker node. Neither pod has a policy.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-02-01)"
```

1. Find out why requests between the two nodes fail. Compare the `cilium-config` keys `routing-mode`, `ipv4-native-routing-cidr` and `auto-direct-node-routes`.
2. Fix the configuration so that each agent installs routes to the pod CIDRs of the other nodes. Change only `cilium-config` and restart the agents.
3. Wait for the agents to be ready. A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200.
