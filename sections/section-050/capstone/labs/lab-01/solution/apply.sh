#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"auto-direct-node-routes":"true"}}'
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
sleep 10
kubectl -n starfleet create configmap routing-evidence --from-literal=routing-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')" --from-literal=ipv4-native-routing-cidr="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipv4-native-routing-cidr}')" --from-literal=probe-node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')" --from-literal=shuttle-node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')" --dry-run=client -o yaml | kubectl apply -f -
