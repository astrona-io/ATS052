#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
kubectl annotate namespace outpost ipam.cilium.io/ip-pool=green --overwrite
kubectl -n outpost rollout restart deployment/drifter
kubectl -n outpost rollout status deployment/drifter --timeout=120s
