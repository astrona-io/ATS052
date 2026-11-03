---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Role Of Cilium Capstone

Solve this question on: `terminal`

The `probe` Service in `starfleet` is the only entry point of the example application. The `shuttle` pod in `starfleet` must use it. The `drifter` pod in `outpost` must be kept out. The platform team also needs a record of how Cilium sees the `probe` pods.

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-cap)"
```

1. Make the Service `probe` forward to both `probe` pods. Change only the Service.
2. Create a CiliumNetworkPolicy named `probe-ingress` in `starfleet` that selects `app: probe` and allows TCP port 9898 only from pods in the namespace `starfleet`.
3. Create the ConfigMap `probe-evidence` in `starfleet` with these keys: `endpoint-count`, the number of addresses behind the Service `probe`; `probe-identity`, the numeric security identity of the `probe` pods (both pods share one identity); `agents-ready`, the number of ready Cilium agent pods.

A request from `shuttle` to `http://probe.starfleet:9898/healthz` must return 200 and the same request from `drifter` must fail. The grader reads live values and compares them with your ConfigMap.
