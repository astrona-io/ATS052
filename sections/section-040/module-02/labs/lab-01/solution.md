---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Run The Operator In High Availability: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-02-01)"
```

## Step 1: Scale the operator

```sh
kubectl -n kube-system get deployment cilium-operator
kubectl -n kube-system scale deployment/cilium-operator --replicas=2
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=180s
```

## Step 2: Check the placement

The chart sets a pod anti-affinity rule on the operator. Each replica must run on its own node. One replica holds the leader lease and does the work. The other waits as a standby.

```sh
kubectl -n kube-system get pods -l io.cilium/app=operator -o wide
```

The two pods show different values in the `NODE` column.

## Step 3: Save the report

The operator registers one CiliumNode object for every node that runs an agent.

```sh
kubectl -n kube-system get deployment cilium-operator -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-operator")].image}{"\n"}'
kubectl get ciliumnodes --no-headers | wc -l
```

```sh
kubectl -n starfleet create configmap component-evidence \
  --from-literal=operator-image="$(kubectl -n kube-system get deployment cilium-operator -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-operator")].image}')" \
  --from-literal=ciliumnode-count="$(kubectl get ciliumnodes --no-headers | wc -l | tr -d ' ')"
```

Submit with `astrona submit -c sections/section-040/module-02/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-040-02-01`.

## Common pitfalls

> [!WARNING]
> If a replica stays Pending, read the events of the pod. A host-network operator and an anti-affinity rule need one free node per replica.
