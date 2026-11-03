---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Restore Hubble Relay And Read Its Service: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-03-01)"
```

## Step 1: Restore the relay

```sh
kubectl -n kube-system get deployment hubble-relay
kubectl -n kube-system scale deployment/hubble-relay --replicas=1
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=180s
```

## Step 2: Check the Service

Clients connect to the Service `hubble-relay`. The relay finds the Hubble servers of the agents through the Service `hubble-peer`.

```sh
kubectl -n kube-system get endpoints hubble-relay
kubectl -n kube-system get service hubble-relay hubble-peer
```

## Step 3: Save the report

```sh
kubectl -n starfleet create configmap hubble-evidence \
  --from-literal=relay-service-port="$(kubectl -n kube-system get service hubble-relay -o jsonpath='{.spec.ports[0].port}')" \
  --from-literal=peer-service-port="$(kubectl -n kube-system get service hubble-peer -o jsonpath='{.spec.ports[0].port}')"
```

Submit with `astrona submit -c sections/section-040/module-03/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-040-03-01`.

## Common pitfalls

> [!WARNING]
> A Service port is not a container port. Read `spec.ports[0].port` of each Service, not the port of a pod.
