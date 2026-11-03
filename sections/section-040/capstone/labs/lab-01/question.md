---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Component Roles Capstone

Solve this question on: `terminal`

Three Cilium components need work before a maintenance window: the operator runs with a single replica, the agents need debug logging, and Hubble Relay is switched off.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-cap)"
```

1. Run two replicas of the Deployment `cilium-operator` on different nodes.
2. Set `debug` to `"true"` in `cilium-config` and restart the DaemonSet `cilium` so that all agents are ready again with the setting.
3. Run one replica of the Deployment `hubble-relay`, and make sure its Service has an endpoint.
