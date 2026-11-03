#!/usr/bin/env bash
# The report holds the live routing settings
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
expect_equal "routing-mode" "$(evidence starfleet routing-evidence routing-mode)" "$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')"
expect_equal "ipv4-native-routing-cidr" "$(evidence starfleet routing-evidence ipv4-native-routing-cidr)" "$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipv4-native-routing-cidr}')"
pass "routing settings match"
