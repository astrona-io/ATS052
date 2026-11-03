#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
node="$(kubectl -n starfleet get pod "$pod" -o jsonpath='{.spec.nodeName}')"
kubectl -n starfleet create configmap address-evidence --from-literal=probe-ip="$(kubectl -n starfleet get pod "$pod" -o jsonpath='{.status.podIP}')" --from-literal=probe-node="$node" --from-literal=node-cidr="$(kubectl get ciliumnode "$node" -o jsonpath='{.spec.ipam.podCIDRs[0]}')" --dry-run=client -o yaml | kubectl apply -f -
