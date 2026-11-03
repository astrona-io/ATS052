---
draft: true
exam_objectives:
- Datapath Models
---
# Verify The Datapath Model Of A Cluster

Solve this question on: `terminal`

An audit asks which datapath model this cluster uses. The answer must come from the Cilium configuration, and a request across nodes must prove that the model works.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-03-01)"
```

Create the ConfigMap `datapath-model` in the namespace `starfleet` with these keys, copied from `cilium-config` in `kube-system`:

1. `routing-mode`
2. `ipv4-native-routing-cidr`
3. `auto-direct-node-routes`
4. `kube-proxy-replacement`
5. `enable-bpf-masquerade`

A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200. Do not change `cilium-config`.
