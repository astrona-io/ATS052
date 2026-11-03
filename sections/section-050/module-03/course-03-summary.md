---
draft: true
exam_objectives:
- Datapath Models
---
# Summary

The datapath model of a cluster is the combination of how pod packets cross nodes, how Services are translated and how source addresses are translated. Each part has a setting in `cilium-config`, and together they describe the datapath.

## What you learned

Tunnel mode wraps each pod packet, asks little of the network and costs bytes and CPU. Native routing sends packets unchanged, needs routes to every pod range and keeps pod addresses visible. The choice depends on what the network can provide: when the routes cannot be changed, the overlay is the safe choice. The model is a cluster-wide setting, and changing it needs a planned restart of all agents.

With kube-proxy replacement, Cilium translates Service addresses in eBPF maps and programs, so no iptables rules are needed for Services. BPF masquerading does the source translation in eBPF in the same spirit. A key that is missing from the ConfigMap uses its default, so confirm the effective value with the agent status. The routing mode, the native routing range, the direct node routes setting, the kube-proxy replacement setting and the masquerade setting together describe the datapath.

- Overlay costs bytes and CPU and needs little from the network.
- Native routing costs nothing per packet and needs routes.
- Kube-proxy replacement moves Service translation into eBPF.
- Five values of `cilium-config` describe a datapath model.

<!-- astrona:playground:destroy -->
