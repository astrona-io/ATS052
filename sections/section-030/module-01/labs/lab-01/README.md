---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Check Node PodCIDR Allocations

Verify distinct Kubernetes PodCIDRs used by Cilium IPAM.

The task and solution use a separate pinned kind cluster. Run `testing/smoke.sh` with its private kubeconfig to verify initial rejection and reference success. Static validation is not live evidence. Runtime verification remains pending.
