---
draft: true
exam_objectives:
- Cilium Architecture
---
# Cilium Architecture Capstone: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-cap)"
```

## Step 1: Add the missing label

The policy is the desired state. The pod labels decide the security identity that the agent programs into the datapath.

```sh
kubectl -n starfleet label pod shuttle role=client
```

Wait a few seconds. The agent on the node of `shuttle` requests the new identity and rebuilds the endpoint.

## Step 2: Read the realised values

```sh
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.identity.id}{"\n"}{.status.id}{"\n"}'
kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.identity.id}{"\n"}'
```

## Step 3: Save the report

```sh
kubectl -n starfleet create configmap identity-evidence \
  --from-literal=shuttle-identity="$(kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.identity.id}')" \
  --from-literal=probe-identity="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.identity.id}')" \
  --from-literal=shuttle-endpoint-id="$(kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.id}')"
```

## Step 4: Test

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
kubectl -n outpost exec drifter -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

Submit with `astrona submit -c sections/section-020/capstone/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-020-cap`.

## Common pitfalls

> [!WARNING]
> Reading the identity of `shuttle` before the label gives the old number. Read it again after the change.
