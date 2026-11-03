#!/usr/bin/env bash
# The report holds the live value of auto-direct-node-routes
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
live="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.auto-direct-node-routes}')"
expect_equal "auto-direct-node-routes" "$(evidence starfleet datapath-model auto-direct-node-routes)" "$live"
pass "auto-direct-node-routes matches"
