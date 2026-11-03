---
draft: true
exam_objectives:
- Datapath Models
---
# Record Overlay Routing Settings And Node Placement: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-01-01)"
```

## Step 1: Read the datapath settings

In overlay mode the agent encapsulates each pod-to-pod packet that leaves a node in a tunnel packet, here VXLAN, and sends it to the destination node.

```sh
kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}{"\n"}{.data.tunnel-protocol}{"\n"}'
```

## Step 2: Read the placement

```sh
kubectl -n starfleet get pods -o wide
```

## Step 3: Save the report and test

```sh
kubectl -n starfleet create configmap overlay-evidence \
  --from-literal=routing-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')" \
  --from-literal=tunnel-protocol="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.tunnel-protocol}')" \
  --from-literal=probe-node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')" \
  --from-literal=shuttle-node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')"
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

Submit with `astrona submit -c sections/section-050/module-01/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-050-01-01`.

## Common pitfalls

> [!WARNING]
> The node names are the names Kubernetes shows in `kubectl get nodes`, not container names or IP addresses.
