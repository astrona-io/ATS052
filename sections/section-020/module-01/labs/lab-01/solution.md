---
draft: true
exam_objectives:
- Cilium Architecture
---
# Repair A Policy Through Pod Labels: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-01-01)"
```

## Step 1: Compare desired state and realised identity

The policy selects sources by label. Cilium turns the labels of a pod into a security identity. Read the labels of `shuttle`, then the identity labels in its CiliumEndpoint.

```sh
kubectl -n starfleet get pod shuttle --show-labels
kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.identity.id}{"\n"}{.status.identity.labels}{"\n"}'
kubectl -n starfleet get ciliumnetworkpolicy probe-from-clients -o jsonpath='{.spec.ingress[0].fromEndpoints}{"\n"}'
```

The pod has only `app=shuttle`. The identity labels do not contain `role=client`, so the policy does not match this identity and the packet is dropped by the datapath on the node of `probe`.

## Step 2: Add the label

Adding a label changes the label set. The Cilium agent on the node of `shuttle` notices the change, asks for the identity of the new label set and updates the endpoint.

```sh
kubectl -n starfleet label pod shuttle role=client
kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.identity.id}{"\n"}'
```

The identity number differs from the number in step 1.

## Step 3: Check both clients

```sh
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
kubectl -n outpost exec drifter -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

The first command prints 200. The second fails. A policy in `starfleet` that names `role: client` matches only pods of `starfleet`, so a label on `drifter` would not change the result. Submit with `astrona submit -c sections/section-020/module-01/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-020-01-01`.

## Common pitfalls

> [!WARNING]
> Do not edit the policy to match the pod. The pod label is the missing fact. Labels are security input: anyone who can label a pod can change the identity it receives.
