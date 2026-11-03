#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n starfleet label pod shuttle role=client --overwrite
sleep 8
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
kubectl -n starfleet create configmap identity-evidence --from-literal=shuttle-identity="$(kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.identity.id}')" --from-literal=probe-identity="$(kubectl -n starfleet get ciliumendpoint "$pod" -o jsonpath='{.status.identity.id}')" --from-literal=shuttle-endpoint-id="$(kubectl -n starfleet get ciliumendpoint shuttle -o jsonpath='{.status.id}')" --dry-run=client -o yaml | kubectl apply -f -
