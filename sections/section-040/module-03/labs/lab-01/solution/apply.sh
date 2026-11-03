#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n kube-system scale deployment/hubble-relay --replicas=1
kubectl -n kube-system rollout status deployment/hubble-relay --timeout=180s
kubectl -n starfleet create configmap hubble-evidence --from-literal=relay-service-port="$(kubectl -n kube-system get service hubble-relay -o jsonpath='{.spec.ports[0].port}')" --from-literal=peer-service-port="$(kubectl -n kube-system get service hubble-peer -o jsonpath='{.spec.ports[0].port}')" --dry-run=client -o yaml | kubectl apply -f -
