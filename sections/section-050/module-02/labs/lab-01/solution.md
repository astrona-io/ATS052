---
draft: true
exam_objectives:
- Datapath Models
---
# Fix Native Routing Between Nodes: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-02-01)"
```

## Step 1: Find the cause

```sh
kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}{"\n"}{.data.ipv4-native-routing-cidr}{"\n"}{.data.auto-direct-node-routes}{"\n"}'
kubectl -n starfleet get pods -o wide
```

The routing mode is `native` and the native routing CIDR covers the pod network. `auto-direct-node-routes` is `false`, so no agent installs a route for the pod CIDR of the other node. The underlay has no such route either.

## Step 2: Enable direct node routes

With the setting on, each agent adds a Linux route for every other node's pod CIDR, with that node's IP address as the next hop. This works only when the nodes share one layer 2 network, as they do here.

```sh
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"auto-direct-node-routes":"true"}}'
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
```

## Step 3: Test

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

The command prints 200. Submit with `astrona submit -c sections/section-050/module-02/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-050-02-01`.

## Common pitfalls

> [!WARNING]
> Do not switch to tunnel mode to hide the problem. The task requires native routing. If the nodes were in different subnets, direct node routes would not work and a router or BGP would have to carry the pod routes.
