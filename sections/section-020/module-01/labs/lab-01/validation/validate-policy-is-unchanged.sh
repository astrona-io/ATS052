#!/usr/bin/env bash
# The CiliumNetworkPolicy still selects role: client and port 9898
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
role="$(kubectl -n starfleet get ciliumnetworkpolicy probe-from-clients -o jsonpath='{.spec.ingress[0].fromEndpoints[0].matchLabels.role}' 2>/dev/null)"
[ "$role" = "client" ] || fail "the policy probe-from-clients was changed or removed"
port="$(kubectl -n starfleet get ciliumnetworkpolicy probe-from-clients -o jsonpath='{.spec.ingress[0].toPorts[0].ports[0].port}')"
[ "$port" = "9898" ] || fail "the policy port was changed"
pass "the policy is unchanged"
