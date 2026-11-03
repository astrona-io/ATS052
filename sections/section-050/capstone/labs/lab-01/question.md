---
draft: true
exam_objectives:
- Datapath Models
---
# Datapath Models Capstone

Solve this question on: `terminal`

This cluster must run native routing, without tunnels. Requests from `shuttle` (control-plane node) to `probe` (worker node) fail. When they work again, the team needs a short record of the model.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-cap)"
```

1. Restore cross-node connectivity without changing the routing mode. Change only `cilium-config` and restart the agents.
2. Create the ConfigMap `routing-evidence` in `starfleet` with the keys `routing-mode`, `ipv4-native-routing-cidr`, `probe-node` and `shuttle-node`, read from the live cluster after the fix.
3. A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200.
