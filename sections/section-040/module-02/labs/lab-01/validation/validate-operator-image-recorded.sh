#!/usr/bin/env bash
# The report holds the live operator image
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
live="$(kubectl -n kube-system get deployment cilium-operator -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-operator")].image}')"
expect_equal "operator-image" "$(evidence starfleet component-evidence operator-image)" "$live"
pass "operator-image matches"
