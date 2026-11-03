---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Separate Service Selection From Policy

Solve this question on: `terminal`

The `shuttle` pod in `starfleet` must reach the Service `probe` on port 9898. Today the request fails. The `drifter` pod in `outpost` must not reach `probe` at all. Two different faults sit between the clients and the server, and each belongs to a different part of the network.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-02-01)"
```

1. Find out why the Service `probe` has no backends, and fix it. Change only the Service. Do not relabel or restart the `probe` pods.
2. Create a CiliumNetworkPolicy named `probe-ingress` in `starfleet`. It must select the pods with the label `app: probe` and allow ingress on TCP port 9898 only from pods in the namespace `starfleet`.
3. When you finish, a request from `shuttle` to `http://probe.starfleet:9898/healthz` must return HTTP 200, and the same request from `drifter` must fail.

Do not delete the policy afterwards and do not use a Kubernetes NetworkPolicy for step 2.
