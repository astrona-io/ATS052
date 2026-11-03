#!/usr/bin/env bash
# shuttle keeps its default-pool address and reaches probe
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
ip="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.status.podIP}')"
case "$ip" in 10.10.*) ;; *) fail "shuttle has the address '$ip', expected an address from 10.10.0.0/16" ;; esac
code="$(http_code starfleet shuttle http://probe.starfleet:9898/healthz)"
[ "$code" = "200" ] || fail "shuttle got HTTP '$code' from probe"
pass "shuttle reaches probe"
