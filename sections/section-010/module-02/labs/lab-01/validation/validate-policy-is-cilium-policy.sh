#!/usr/bin/env bash
# A CiliumNetworkPolicy probe-ingress protects the probe pods on port 9898
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
selector="$(kubectl -n starfleet get ciliumnetworkpolicy probe-ingress -o jsonpath='{.spec.endpointSelector.matchLabels.app}' 2>/dev/null)"
[ "$selector" = "probe" ] || fail "CiliumNetworkPolicy probe-ingress with endpointSelector app=probe not found"
port="$(kubectl -n starfleet get ciliumnetworkpolicy probe-ingress -o jsonpath='{.spec.ingress[*].toPorts[*].ports[*].port}')"
[ "$port" = "9898" ] || fail "the policy must allow only port 9898, found '$port'"
pass "the policy exists and names port 9898"
