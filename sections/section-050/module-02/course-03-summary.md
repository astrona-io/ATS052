---
draft: true
exam_objectives:
- Datapath Models
---
# Summary

Native routing sends pod packets without wrapping them, so they keep their pod addresses across the network. This removes the overhead of an overlay and keeps the traffic visible to the network, but every hop needs a route to each pod range.

## What you learned

Native routing is selected with `routing-mode` set to `native`. The setting `ipv4-native-routing-cidr` must cover all pod ranges, and it also marks the destinations that are not translated. With `auto-direct-node-routes` true, each agent installs a route to the pod range of every other node. This works only when the nodes share a layer 2 network. Otherwise the routes come from a cloud route table, from BGP or from static entries.

Masquerading replaces the pod source address with the node address for traffic that leaves the native routing range. A range that is too small translates traffic that should stay unchanged. A range that is too large stops translating traffic that needs it. The setting `enable-bpf-masquerade` selects the eBPF implementation.

- Native routing needs a route to every pod range on every hop.
- Direct node routes need nodes in one layer 2 network.
- BGP and cloud route tables are the alternatives.
- The covering range controls masquerading.

<!-- astrona:playground:destroy -->
