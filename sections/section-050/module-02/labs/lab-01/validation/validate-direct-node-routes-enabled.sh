#!/usr/bin/env bash
# auto-direct-node-routes is "true" and routing stays native
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
value="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.auto-direct-node-routes}')"
[ "$value" = "true" ] || fail "auto-direct-node-routes is '$value', expected 'true'"
mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')"
[ "$mode" = "native" ] || fail "routing-mode is '$mode', it must stay 'native'"
pass "direct node routes are enabled in native mode"
