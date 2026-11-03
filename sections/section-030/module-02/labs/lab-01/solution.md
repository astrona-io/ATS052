---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Trace A Pod Address To Its Node Allocation: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-02-01)"
```

## Step 1: Find the pod, its address and its node

```sh
kubectl -n starfleet get pods -l app=probe -o wide
```

## Step 2: Read the node allocation

The CiliumNode object has the same name as the node. The field `spec.ipam.podCIDRs` lists the slices that the operator gave to that node. The agent on the node hands out pod addresses from them.

```sh
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
node="$(kubectl -n starfleet get pod "$pod" -o jsonpath='{.spec.nodeName}')"
kubectl get ciliumnode "$node" -o jsonpath='{.spec.ipam.podCIDRs[0]}{"\n"}'
```

## Step 3: Save the report

```sh
kubectl -n starfleet create configmap address-evidence \
  --from-literal=probe-ip="$(kubectl -n starfleet get pod "$pod" -o jsonpath='{.status.podIP}')" \
  --from-literal=probe-node="$node" \
  --from-literal=node-cidr="$(kubectl get ciliumnode "$node" -o jsonpath='{.spec.ipam.podCIDRs[0]}')"
```

Submit with `astrona submit -c sections/section-030/module-02/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-030-02-01`.

## Common pitfalls

> [!WARNING]
> Read the CiliumNode object, not only the Kubernetes Node. In `cluster-pool` mode the two can differ, and only the CiliumNode holds the slice Cilium uses.
