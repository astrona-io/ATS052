# Prerequisites

- The `astrona` command-line tool, installed and working.
- A container engine that kind can use (Podman or Docker) with about 4 GiB of free memory, because the cluster has two nodes and runs Cilium.
- `kubectl`, `helm` and `jq`.
- Basic knowledge of Pods, Deployments, Services and namespaces.

The lab starts a two-node kind cluster (Kubernetes v1.35.0) without a default network plugin, installs Cilium 1.20.2 from the pinned chart, and creates the example workloads in `starfleet` and `outpost`.
