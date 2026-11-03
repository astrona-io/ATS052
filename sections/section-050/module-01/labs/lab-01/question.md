---
draft: true
exam_objectives:
- Datapath Models
---
# Record Overlay Routing Settings And Node Placement

Solve this question on: `terminal`

Traffic from `shuttle` to `probe` crosses two nodes. The network team wants to document the datapath model that carries it and the nodes that hold the two pods.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-01-01)"
```

Create the ConfigMap `overlay-evidence` in the namespace `starfleet` with these keys:

1. `routing-mode`: the value of the `routing-mode` key in `cilium-config`.
2. `tunnel-protocol`: the value of the `tunnel-protocol` key in `cilium-config`.
3. `probe-node`: the node that runs the `probe` pod.
4. `shuttle-node`: the node that runs the `shuttle` pod.

A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200. Do not change `cilium-config`.
