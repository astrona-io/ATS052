---
draft: true
exam_objectives:
- Cilium Architecture
---
# Security Identities In Cilium

Traditional firewalls match packets by IP address. In Kubernetes this does not work well, because a pod gets a new address every time it is rescheduled, and a Deployment can have hundreds of pods that come and go. Cilium solves this by giving every group of pods with the same labels one numeric identity and by writing its policy against identities instead of addresses.

Keep one sentence in mind: **the labels of a pod decide its identity, and the identity decides what policy applies.** You will read the identities that Cilium created, change the labels of a running pod and watch its identity change, and use that to repair a policy that denies a legitimate client.

The module has two parts. The first part explains how labels become identities, which labels count, and where identities are stored. The second part follows the identity through the datapath and shows how policy decisions are made from it.

## Learning objectives

After this module you can:

- Explain how Cilium derives a security identity from the labels of a pod.
- Name the reserved identities and say what each one represents.
- Read the identity of a pod from its `CiliumEndpoint`.
- Explain why a label change on a running pod can change its access.
- Describe how an identity reaches the datapath and how a policy decision uses it.

## Before you start

You need Kubernetes basics: labels, selectors, namespaces and the commands `kubectl get`, `kubectl label` and `kubectl exec`.

Your playground is a two-node kind cluster with Cilium 1.20.2.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` (two pods) and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Pod `drifter` | A client pod with `curl` in another namespace |

No policy exists at the start. Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
