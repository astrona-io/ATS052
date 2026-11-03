---
draft: true
exam_objectives:
- Datapath Models
---
# Summary

An overlay lets pods on different nodes talk without any change to the network under the nodes. Each pod packet is wrapped in an outer packet between node addresses, and the node network delivers it like any other traffic between two nodes.

## What you learned

In tunnel mode the eBPF program on a pod interface finds the node of the destination pod in the ipcache and sends the packet to the tunnel device. The destination node removes the outer header and delivers the inner packet. The network below needs no routes for pod ranges, only delivery of UDP between nodes and an open tunnel port. A blocked port breaks cross-node traffic while same-node traffic continues.

Cilium supports VXLAN on UDP 8472 and Geneve on UDP 6081. The protocol is a cluster-wide setting. The wrapping adds bytes to each packet, about 50 for VXLAN, so the pod MTU is the node MTU minus the overhead. Cilium sets this automatically. A wrong MTU leaves small requests working and large transfers stalling.

- Overlay needs little from the network and costs bytes and CPU per packet.
- The tunnel protocol and its port must match on all nodes.
- The pod MTU is the node MTU minus the encapsulation overhead.
- Same-node traffic working with cross-node traffic failing points to the path between nodes.

<!-- astrona:playground:destroy -->
