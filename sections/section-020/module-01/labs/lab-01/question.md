---
draft: true
exam_objectives:
- Cilium Architecture
---
# Compare Endpoint Intent With Realised Identity

Map a Pod to its CiliumEndpoint and realised identity.

## Starting state

Cilium manages the private two-node cluster. Hubble Relay and the BGP control plane are enabled. The probe and two clients are healthy; no learner policy or evidence report exists. This baseline uses kube-proxy and tunnelling.

Use a host shell with the private kubeconfig for this independent kind environment. A kubeconfig identifies the cluster and credentials used by kubectl, the Kubernetes command-line tool.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-020-01-01)"
test "$(kubectl config current-context)" = "kind-astro-ats-052-lab-020-01-01" || exit 1
node_name="astro-ats-052-lab-020-01-01-control-plane"
worker_name="astro-ats-052-lab-020-01-01-worker"
```

Keep this connection selected. Host-level commands name only this environment's node containers. They do not operate on the host operating system.

## Required result

Record the shuttle Pod address, endpoint identity and endpoint state. Check that endpoint status is ready. Resource intent and reconciled state are separate observations.

Record observations in `starfleet/evidence`, whose `report.json` contains the stated report. The verifier reads the live API again; invented values do not pass.

The report object uses these fields: `pod_ip`, `identity`, `state`. Keep numeric values numeric and preserve arrays and nested objects returned by the API.

## Verify The Result

The grader checks the required object fields and actual observations. Wait for controller convergence before submitting. Preserve the task's namespace, workload names and unrelated components.
