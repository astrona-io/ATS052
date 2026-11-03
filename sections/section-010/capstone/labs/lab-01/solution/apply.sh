#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl -n starfleet patch service probe --type merge -p '{"spec":{"selector":{"app":"probe"}}}'
kubectl apply -f - <<'POLICY'
apiVersion: cilium.io/v2
kind: CiliumNetworkPolicy
metadata:
  name: probe-ingress
  namespace: starfleet
spec:
  endpointSelector:
    matchLabels:
      app: probe
  ingress:
  - fromEndpoints:
    - matchLabels:
        k8s:io.kubernetes.pod.namespace: starfleet
    toPorts:
    - ports:
      - port: "9898"
        protocol: TCP
POLICY
for attempt in $(seq 1 20); do
  count="$(kubectl -n starfleet get endpoints probe -o jsonpath='{.subsets[*].addresses[*].ip}' | wc -w | tr -d ' ')"
  [ "$count" = "2" ] && break
  sleep 3
done
probe_pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
identity="$(kubectl -n starfleet get ciliumendpoint "$probe_pod" -o jsonpath='{.status.identity.id}')"
ready="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}')"
kubectl -n starfleet create configmap probe-evidence --from-literal=endpoint-count="$count" --from-literal=probe-identity="$identity" --from-literal=agents-ready="$ready" --dry-run=client -o yaml | kubectl apply -f -
sleep 5
