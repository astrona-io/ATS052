#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n starfleet create configmap overlay-evidence --from-literal=routing-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')" --from-literal=tunnel-protocol="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.tunnel-protocol}')" --from-literal=probe-node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')" --from-literal=shuttle-node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')" --dry-run=client -o yaml | kubectl apply -f -
