---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Change Agent Settings And Restart The Agents

Solve this question on: `terminal`

An engineer needs debug logging from the Cilium agents on every node to investigate a problem. The agents read their settings from the ConfigMap `cilium-config` in `kube-system` only when they start. The change must reach every agent, and no node may be left without a ready agent.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-01-01)"
```

1. Set the key `debug` in `cilium-config` to `"true"`.
2. Restart the DaemonSet `cilium` so that every agent pod starts again with the new setting.
3. Wait until the DaemonSet is fully ready again. Do not delete other Cilium objects.
