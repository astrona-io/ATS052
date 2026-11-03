---
draft: true
exam_objectives:
- Cilium Architecture
---
# Read Endpoint State From Cilium Objects

Solve this question on: `terminal`

An engineer wants to know how Cilium represents the `probe` pod inside the cluster: its endpoint number, its security identity and the state of its endpoint. Read the values from the live objects.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-02-01)"
```

Create the ConfigMap `datapath-evidence` in the namespace `starfleet` with these keys, all for the single `probe` pod (label `app=probe`):

1. `probe-endpoint-id`: the numeric endpoint ID (`status.id` of its CiliumEndpoint).
2. `probe-identity`: the numeric security identity (`status.identity.id`).
3. `probe-endpoint-state`: the endpoint state (`status.state`).

The grader reads the same values from the live API. Do not change any workload or Cilium object.
