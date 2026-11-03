#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n starfleet create configmap ipam-evidence --from-literal=ipam-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipam}')" --from-literal=pool-cidr="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.cluster-pool-ipv4-cidr}')" --from-literal=mask-size="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.cluster-pool-ipv4-mask-size}')" --dry-run=client -o yaml | kubectl apply -f -
