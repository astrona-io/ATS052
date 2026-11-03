---
draft: true
exam_objectives:
- Datapath Models
---
# Datapath Models Capstone: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-cap)"
```

## Step 1: Fix the routes

In native routing mode, each node must know the next hop for the pod CIDR of the other node. On one layer 2 network the agent can install those routes itself.

```sh
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"auto-direct-node-routes":"true"}}'
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
```

## Step 2: Test and record

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
kubectl -n starfleet create configmap routing-evidence \
  --from-literal=routing-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')" \
  --from-literal=ipv4-native-routing-cidr="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipv4-native-routing-cidr}')" \
  --from-literal=probe-node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')" \
  --from-literal=shuttle-node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')"
```

Submit with `astrona submit -c sections/section-050/capstone/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-050-cap`.

## Common pitfalls

> [!WARNING]
> The pods must stay on different nodes. A request between two pods on the same node would pass without proving anything about routing between nodes.
