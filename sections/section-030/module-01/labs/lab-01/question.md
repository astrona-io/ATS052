---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Record The IPAM Mode And Pool Settings

Solve this question on: `terminal`

The network team must document how this cluster hands out pod IP addresses. The settings are in the ConfigMap `cilium-config` in `kube-system`, which the Cilium agent and the Cilium operator both read. Do not guess the values.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-01-01)"
```

Create the ConfigMap `ipam-evidence` in the namespace `starfleet` with these keys:

1. `ipam-mode`: the value of the `ipam` key in `cilium-config`.
2. `pool-cidr`: the value of the `cluster-pool-ipv4-cidr` key.
3. `mask-size`: the value of the `cluster-pool-ipv4-mask-size` key.

The grader reads the live `cilium-config` and compares. Do not change `cilium-config`.
