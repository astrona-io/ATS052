---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Separate Service Selection From Policy: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-02-01)"
```

## Step 1: Find the missing backends

A Service forwards only to pods that match its selector and are ready. Compare the Service selector with the pod labels.

```sh
kubectl -n starfleet get service probe -o jsonpath='{.spec.selector}'
kubectl -n starfleet get pods --show-labels
kubectl -n starfleet get endpoints probe
```

The selector asks for `app: probe-api`, but the pods have `app: probe`, so the Endpoints object has no addresses. This is a Service fault. Policy is not involved yet.

## Step 2: Correct the selector

```sh
kubectl -n starfleet patch service probe --type merge -p '{"spec":{"selector":{"app":"probe"}}}'
kubectl -n starfleet get endpoints probe
```

## Step 3: Write the policy

A CiliumNetworkPolicy selects the pods it protects with `endpointSelector`. An ingress rule with `fromEndpoints` lists the allowed sources. The label `k8s:io.kubernetes.pod.namespace` matches the namespace of the source pod.

Save this as `cnp-probe-ingress.yaml`:

```yaml
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: probe-ingress
  namespace: starfleet
spec:
  endpointSelector:
    matchLabels:
      app: probe
  ingress:
  - fromEndpoints:
    - matchLabels:
        k8s:io.kubernetes.pod.namespace: starfleet
    toPorts:
    - ports:
      - port: "9898"
        protocol: TCP
```

Apply it:

```sh
kubectl apply -f cnp-probe-ingress.yaml
```

## Step 4: Check both clients

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
kubectl -n outpost exec drifter -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

The first command must print 200. The second must fail or print 000 after the timeout. Submit with `astrona submit -c sections/section-010/module-02/labs/lab-01`, then remove the environment with `astrona destroy ats-052-lab-010-02-01`.

## Common pitfalls

> [!WARNING]
> A timeout does not name the failing layer. Check the Service endpoints first, then the policy. A policy that selects `probe` pods starts denying all other ingress to them the moment it exists.
