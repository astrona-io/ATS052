#!/usr/bin/env bash
# Every running probe pod has an address from 10.30.0.0/16
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
kubectl -n starfleet rollout status deployment/probe --timeout=90s >/dev/null 2>&1 || fail "the probe rollout is not complete"
ips="$(kubectl -n starfleet get pods -l app=probe -o json | jq -r '.items[] | select(.metadata.deletionTimestamp==null) | .status.podIP')"
count="$(echo "$ips" | wc -w | tr -d ' ')"
[ "$count" = "2" ] || fail "expected 2 running probe pods, found $count"
for ip in $ips; do
  case "$ip" in 10.30.*) ;; *) fail "probe has the address $ip, expected an address from 10.30.0.0/16" ;; esac
done
pass "probe pods use amber"
