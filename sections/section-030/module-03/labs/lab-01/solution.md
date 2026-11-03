---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Select A Pod IP Pool For A Namespace: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-03-01)"
```

## Step 1: Look at the pools and the current address

```sh
kubectl get ciliumpodippools
kubectl -n outpost get pods -o wide
```

Both pools exist. The `drifter` pod has an address from 10.10.0.0/16, the `default` pool.

## Step 2: Annotate the namespace

The Cilium agent reads the annotation `ipam.cilium.io/ip-pool` when it creates a pod. A namespace annotation applies to every new pod in the namespace.

```sh
kubectl annotate namespace outpost ipam.cilium.io/ip-pool=green
```

## Step 3: Recreate the pod

An annotation change does not affect a running pod. The Deployment creates a new pod when you restart it.

```sh
kubectl -n outpost rollout restart deployment/drifter
kubectl -n outpost rollout status deployment/drifter
kubectl -n outpost get pods -o wide
```

The new pod has an address in 10.20.0.0/16. Submit with `astrona submit -c sections/section-030/module-03/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-030-03-01`.

## Common pitfalls

> [!WARNING]
> Annotating a namespace does not change running pods. A pod that was created before the annotation keeps its address until it is recreated.
