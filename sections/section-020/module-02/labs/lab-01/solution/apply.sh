#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
kubectl -n starfleet create configmap datapath-evidence --from-literal=probe-endpoint-id="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.id}')" --from-literal=probe-identity="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.identity.id}')" --from-literal=probe-endpoint-state="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.state}')" --dry-run=client -o yaml | kubectl apply -f -
