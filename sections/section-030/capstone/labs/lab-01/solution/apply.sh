#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl apply -f - <<'POOL'
apiVersion: cilium.io/v2alpha1
kind: CiliumPodIPPool
metadata:
  name: amber
spec:
  ipv4:
    cidrs:
    - 10.30.0.0/16
    maskSize: 24
POOL
kubectl -n starfleet patch deployment probe --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"ipam.cilium.io/ip-pool":"amber"}}}}}'
kubectl -n starfleet rollout status deployment/probe --timeout=180s
