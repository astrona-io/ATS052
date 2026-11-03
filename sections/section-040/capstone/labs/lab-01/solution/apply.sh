#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n kube-system scale deployment/cilium-operator --replicas=2
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=180s
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"debug":"true"}}'
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
kubectl -n kube-system scale deployment/hubble-relay --replicas=1
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=180s
