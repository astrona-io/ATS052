---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Role Of Cilium Capstone: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-cap)"
```

## Step 1: Fix the Service

```sh
kubectl -n starfleet get endpoints probe
kubectl -n starfleet patch service probe --type merge -p '{"spec":{"selector":{"app":"probe"}}}'
kubectl -n starfleet get endpoints probe
```

The first command shows no addresses: the selector `app: probe-api` matches no pod. After the patch, the Endpoints object lists two addresses.

## Step 2: Add the policy

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

## Step 3: Record the evidence

Pods from one Deployment share the same labels, so they share one Cilium security identity. Read it from one of the CiliumEndpoint objects.

```sh
probe_pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
kubectl -n starfleet get ciliumendpoint "$probe_pod" -o jsonpath='{.status.identity.id}'
kubectl -n starfleet get endpoints probe -o jsonpath='{.subsets[*].addresses[*].ip}'
kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}'
```

Then create the ConfigMap with the three values:

```sh
kubectl -n starfleet create configmap probe-evidence \
  --from-literal=endpoint-count=2 \
  --from-literal=probe-identity="<identity from above>" \
  --from-literal=agents-ready="<number from above>"
```

Replace the two placeholders with the printed values. The endpoint count is the number of addresses printed by the second command. Submit with `astrona submit -c sections/section-010/capstone/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-010-cap`.

## Common pitfalls

> [!WARNING]
> The identity belongs to the label set, not to one pod. Check that both pods give the same number. Do not edit the `probe` Deployment: the fault is in the Service.
