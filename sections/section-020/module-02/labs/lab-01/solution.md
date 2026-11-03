---
draft: true
exam_objectives:
- Cilium Architecture
---
# Read Endpoint State From Cilium Objects: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-02-01)"
```

## Step 1: Find the pod and its CiliumEndpoint

A CiliumEndpoint has the same name and namespace as its pod.

```sh
kubectl -n starfleet get pods -l app=probe
kubectl -n starfleet get ciliumendpoint
```

## Step 2: Read the three fields

```sh
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.id}{"\n"}{.status.identity.id}{"\n"}{.status.state}{"\n"}'
```

The endpoint ID is a number that is unique on one node. The security identity is a number that is shared by every pod with the same labels in the cluster. The state shows whether the agent finished building the datapath for the endpoint.

## Step 3: Save the report

```sh
kubectl -n starfleet create configmap datapath-evidence \
  --from-literal=probe-endpoint-id="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.id}')" \
  --from-literal=probe-identity="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.identity.id}')" \
  --from-literal=probe-endpoint-state="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.state}')"
```

Submit with `astrona submit -c sections/section-020/module-02/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-020-02-01`.

## Common pitfalls

> [!WARNING]
> The endpoint ID and the security identity are different numbers. Using the identity for both keys fails the check. The state is text, not a number.
