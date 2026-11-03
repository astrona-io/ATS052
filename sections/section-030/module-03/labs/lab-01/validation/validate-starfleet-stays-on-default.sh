#!/usr/bin/env bash
# The shuttle pod still uses the default pool and the pools are unchanged
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
pod_ips() { kubectl -n "$1" get pods -l "$2" -o json | jq -r '.items[] | select(.metadata.deletionTimestamp==null) | .status.podIP'; }
ip="$(pod_ips starfleet app=shuttle)"
case "$ip" in 10.10.*) ;; *) fail "shuttle has the address '$ip', expected an address from 10.10.0.0/16" ;; esac
cidr="$(kubectl get ciliumpodippool green -o jsonpath='{.spec.ipv4.cidrs[0]}' 2>/dev/null)"
[ "$cidr" = "10.20.0.0/16" ] || fail "the pool green was changed or removed"
pass "starfleet stays on the default pool"
