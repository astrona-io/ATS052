#!/usr/bin/env bash
# Routing stays native and direct node routes are enabled
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')"
[ "$mode" = "native" ] || fail "routing-mode is '$mode', it must stay 'native'"
value="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.auto-direct-node-routes}')"
[ "$value" = "true" ] || fail "auto-direct-node-routes is '$value', expected 'true'"
restarted="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.spec.template.metadata.annotations.kubectl\.kubernetes\.io/restartedAt}')"
[ -n "$restarted" ] || fail "the agents were not restarted"
pass "native routing with direct node routes"
