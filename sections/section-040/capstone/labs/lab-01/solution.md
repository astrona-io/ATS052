---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Component Roles Capstone: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-cap)"
```

## Step 1: The operator

```sh
kubectl -n kube-system scale deployment/cilium-operator --replicas=2
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=180s
kubectl -n kube-system get pods -l io.cilium/app=operator -o wide
```

## Step 2: The agents

The agents read `cilium-config` at start, so the restart is part of the change.

```sh
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"debug":"true"}}'
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
```

## Step 3: Hubble Relay

```sh
kubectl -n kube-system scale deployment/hubble-relay --replicas=1
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=180s
kubectl -n kube-system get endpoints hubble-relay
```

Submit with `astrona submit -c sections/section-040/capstone/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-040-cap`.

## Common pitfalls

> [!WARNING]
> Restart the agents only after the operator change finished, so you change one component at a time and know which change caused a problem.
