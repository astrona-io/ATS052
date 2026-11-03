#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n kube-system scale deployment/cilium-operator --replicas=2
kubectl -n kube-system rollout status deployment/cilium-operator --timeout=180s
kubectl -n starfleet create configmap component-evidence --from-literal=operator-image="$(kubectl -n kube-system get deployment cilium-operator -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-operator")].image}')" --from-literal=ciliumnode-count="$(kubectl get ciliumnodes --no-headers | wc -l | tr -d ' ')" --dry-run=client -o yaml | kubectl apply -f -
