---
draft: true
exam_objectives:
- Datapath Models
---
# Overlay And Native Routing Packet Paths

The datapath is the sequence of mechanisms that carries and processes traffic. Cilium can use different routing models, with different requirements for the network beneath the cluster. Understanding the selected model helps explain why same-node traffic works while cross-node traffic fails, or why only particular packet sizes encounter trouble.

## Overlay Encapsulation

In an overlay model, a workload packet is carried inside another packet between node endpoints, using a supported tunnel protocol such as VXLAN or Geneve. The underlying network primarily needs to reach the node addresses and permit the tunnel traffic. It does not need to understand every workload prefix in the same way as native routing.

The receiving node decapsulates and delivers the packet according to its local state. Outer and inner addresses describe different layers. An infrastructure firewall sees node-to-node tunnel traffic, while endpoint policy can evaluate the workload relationship. A rule applied to one layer should not be assumed to identify the same peers visible at another layer.

## Native Routing

Native routing sends workload traffic without that overlay wrapper under the selected network model. Hosts or infrastructure must provide routes to the workload addresses. This can fit environments where the underlay already supports Pod ranges or cloud-integrated addressing, but requires deliberate route and address planning.

A Pod allocated an address is not automatically reachable from every node or external router. The forward and return paths must agree. An external system that receives a packet can still lack a route back to the workload source, producing a one-way failure that resembles application silence.

## MTU And Packet Size

Encapsulation adds headers and reduces the payload that fits within the outer network's MTU. Encryption and other processing can also add overhead. A small connection setup can succeed while a larger transfer stalls if the path does not handle the resulting packet sizes or relevant error feedback correctly.

Use the complete path's supported MTU model rather than copy the physical interface value into every workload setting. Different paths can have different constraints. A successful small request is evidence for that request, not proof that all larger traffic works.

## Masquerading Changes The Visible Source

Source address translation or masquerading can make traffic appear to originate from a node or another selected address. It can support external connectivity where the destination cannot route Pod addresses directly. That changes the source visible to the external service and its allowlists or logs.

Masquerading is not a substitute for correct policy or authentication. It also does not create every missing route or guarantee that replies traverse the expected stateful path. Review source preservation requirements, exclusions and external return routing under the actual deployment configuration.

## Keep Security Relationships Separate

Overlay encapsulation is not automatically encryption. Native routing is not automatically unprotected or permitted. Transparent encryption, endpoint policy and application TLS add their own mechanisms and supported coverage. A routable packet can be denied by policy, while an allowed policy does not repair a missing route.

For a failure, identify same-node versus cross-node scope, the selected outer path, effective source and destination, return routing and packet-size behavior. Then inspect policy and application evidence. This ordered model narrows the failing relationship without discarding protections unrelated to the defect.

## Common pitfalls

> [!WARNING]
> Encapsulation does not imply encryption. Address allocation, routes, MTU, source translation and policy must agree, and small-packet success does not establish every payload path.
