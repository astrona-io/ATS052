---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# IPAM Capstone: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-030-cap)"
```

## Step 1: Create the pool

A CiliumPodIPPool describes the CIDRs of a pool and the size of the slice that each node receives. The mask size cannot change after you create the pool.

Save this as `pool-amber.yaml`:

```yaml
apiVersion: cilium.io/v2alpha1
kind: CiliumPodIPPool
metadata:
  name: amber
spec:
  ipv4:
    cidrs:
    - 10.30.0.0/16
    maskSize: 24
```

Apply it:

```sh
kubectl apply -f pool-amber.yaml
kubectl get ciliumpodippools
```

## Step 2: Annotate the pod template

The annotation must be on the pods, so it goes into `spec.template.metadata.annotations`. Changing the template makes the Deployment roll out new pods.

```sh
kubectl -n starfleet patch deployment probe --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"ipam.cilium.io/ip-pool":"amber"}}}}}'
kubectl -n starfleet rollout status deployment/probe
kubectl -n starfleet get pods -o wide
```

## Step 3: Check the clients

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

The command prints 200. `shuttle` keeps its address from 10.10.0.0/16. Submit with `astrona submit -c sections/section-030/capstone/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-030-cap`.

## Common pitfalls

> [!WARNING]
> Put the annotation on the pod template, not on the Deployment metadata. The Deployment metadata does not reach the pods.
