#!/usr/bin/env bash
# The running drifter pod has an address from 10.20.0.0/16
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
pod_ips() { kubectl -n "$1" get pods -l "$2" -o json | jq -r '.items[] | select(.metadata.deletionTimestamp==null) | .status.podIP'; }
kubectl -n outpost rollout status deployment/drifter --timeout=60s >/dev/null 2>&1 || fail "the drifter rollout is not complete"
ips="$(pod_ips outpost app=drifter)"
[ -n "$ips" ] || fail "no running drifter pod"
for ip in $ips; do
  case "$ip" in 10.20.*) ;; *) fail "drifter has the address $ip, expected an address from 10.20.0.0/16" ;; esac
done
pass "drifter uses the green pool"
