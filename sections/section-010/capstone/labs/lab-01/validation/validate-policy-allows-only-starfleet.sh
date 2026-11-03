#!/usr/bin/env bash
# shuttle reaches probe, drifter does not, through a CiliumNetworkPolicy
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
selector="$(kubectl -n starfleet get ciliumnetworkpolicy probe-ingress -o jsonpath='{.spec.endpointSelector.matchLabels.app}' 2>/dev/null)"
[ "$selector" = "probe" ] || fail "CiliumNetworkPolicy probe-ingress with endpointSelector app=probe not found"
code="$(http_code starfleet shuttle http://probe.starfleet:9898/healthz)"
[ "$code" = "200" ] || fail "shuttle got HTTP '$code'"
code="$(http_code outpost drifter http://probe.starfleet:9898/healthz)"
[ "$code" != "200" ] || fail "drifter reached probe"
pass "shuttle is allowed and drifter is blocked"
