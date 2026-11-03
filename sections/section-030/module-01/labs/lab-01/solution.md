---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Record The IPAM Mode And Pool Settings: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-01-01)"
```

## Step 1: Read the settings

`cilium-config` holds the agent and operator settings as text keys. The IPAM mode decides who allocates addresses. In `cluster-pool` mode the Cilium operator hands each node a slice of the pool.

```sh
kubectl -n kube-system get configmap cilium-config -o yaml | grep -E 'ipam|cluster-pool'
```

## Step 2: Save the report

```sh
kubectl -n starfleet create configmap ipam-evidence \
  --from-literal=ipam-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipam}')" \
  --from-literal=pool-cidr="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.cluster-pool-ipv4-cidr}')" \
  --from-literal=mask-size="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.cluster-pool-ipv4-mask-size}')"
```

Submit with `astrona submit -c sections/section-030/module-01/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-030-01-01`.

## Common pitfalls

> [!WARNING]
> The key names contain hyphens. In jsonpath, write `{.data.cluster-pool-ipv4-cidr}` without quotes around the key, exactly as shown. A node can show a podCIDR in the Kubernetes Node object, but in `cluster-pool` mode Cilium ignores it.
