---
draft: true
exam_objectives:
- Datapath Models
---
# Kube-Proxy Replacement And Masquerading

Two settings affect the datapath in every model: whether Cilium replaces kube-proxy, and how it masquerades. This part explains both, shows how to read their state from a running cluster and explains why the two are related.

## What kube-proxy does

Kube-proxy is a Kubernetes component that runs on every node and implements Services. It watches Services and EndpointSlices and writes rules, usually iptables or IPVS rules, that translate the Service address to a pod address. Each packet to a Service passes through these rules.

## Kube-proxy replacement

Cilium can do the same work with eBPF. With the setting `kube-proxy-replacement` enabled, the agent builds the Service translation in eBPF maps and programs. A connection to a Service address is translated to a backend pod address at the socket call or at the interface, with no iptables rules involved. The Service list of the agent shows what it built.

Replacing kube-proxy has several effects.

- Translation by a map lookup is faster than a long chain of rules when there are many Services.
- Cilium can handle NodePort, LoadBalancer and external addresses without kube-proxy.
- The translation for traffic from a pod happens at its socket, so the Service address never appears on the network.
- Kube-proxy must not run on the same nodes, or it must be set so that the two do not conflict.

```mermaid
flowchart LR
    A["Client to Service address"] --> B["Cilium eBPF Service map"]
    B --> C["Select a backend pod"]
    C --> D["Send to the pod address"]
```

## BPF masquerading

The earlier part explained that masquerading replaces the pod source address when traffic leaves the cluster range. There are two implementations. In the iptables implementation, rules on the node do the translation. In the eBPF implementation, selected with `enable-bpf-masquerade`, a program on the node interface does it. The eBPF version is faster and avoids iptables rules, and it needs a recent kernel and the right device selection.

## Why they are related

The eBPF implementation of masquerading and the replacement of kube-proxy rely on the same device handling and the same kernel features. Because of this, installations that use full replacement usually enable eBPF masquerading as well. Read both values when you describe a datapath model, because together they tell whether iptables is still in the path.

## Try it

Read the two settings and see what the agent built.

<!-- astrona:playground:renew -->

Read the keys from the ConfigMap.

```sh
kubectl -n kube-system get configmap cilium-config -o yaml | grep -E 'kube-proxy-replacement|bpf-masquerade|masquerade'
```

A key that is not printed uses its default value. Now ask the agent for the Service list and the status.

```sh
kubectl -n kube-system exec daemonset/cilium -c cilium-agent -- cilium-dbg service list
kubectl -n kube-system exec daemonset/cilium -c cilium-agent -- cilium-dbg status --verbose
```

Compare the Services in the list with the Services of the cluster, and look in the status for the kube-proxy replacement and masquerade lines. Check whether kube-proxy exists in this cluster.

```sh
kubectl -n kube-system get daemonset
```

If no kube-proxy DaemonSet is listed, Cilium handles the Services.

## Reading a model for an audit

To describe the datapath of a cluster for someone else, record five values from `cilium-config`: the routing mode, the native routing range, the direct node routes setting, the kube-proxy replacement setting and the BPF masquerade setting. Together they answer how packets cross nodes, what the network must provide, who translates Services and who translates source addresses. Record the value of each key as it is in the live ConfigMap and not as the chart documentation says, because the live value is what the agents run with after their last restart.

## What to remember

Kube-proxy replacement lets Cilium translate Services in eBPF instead of iptables rules. BPF masquerading does the source translation in eBPF. Both depend on similar kernel features and are often enabled together. The five values of `cilium-config` give a full description of the datapath model of a cluster.

## NodePort and external traffic

A NodePort Service opens a port on every node. With kube-proxy, iptables rules on the node accept the traffic and pick a backend. With the replacement, an eBPF program on the node interface does it. If the backend runs on another node, the packet is forwarded there, and the reply must return the same way so that the client sees an answer from the address that it contacted.

Cilium handles this with source address translation or with direct server return, depending on the configuration. Direct server return lets the backend answer the client directly. It keeps the client address visible but needs a network that allows the asymmetric path.

## Socket-level translation

For traffic that starts in a pod, Cilium can translate the Service address at the socket call, before the packet exists. The application connects to the Service address, and the kernel program replaces it with a backend address in the connection itself. The network never sees the Service address, and no per-packet translation is needed for these connections.

## Checking that kube-proxy is not in the way

If both kube-proxy and the replacement are active, the two can handle the same traffic and conflict. Check the DaemonSets of `kube-system` and the setting `kube-proxy-replacement`. In a kind cluster created without kube-proxy, only Cilium translates Services. In another cluster, the migration needs a plan for removing kube-proxy and its rules.

## Common pitfalls

> [!WARNING]
> A key that is missing from `cilium-config` is not necessarily off. It may use a default that depends on the release. Confirm the effective value with the agent status before you record it.
