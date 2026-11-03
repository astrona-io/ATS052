#!/usr/bin/env bash
# The Service probe selects the probe pods and has endpoints
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
selector="$(kubectl -n starfleet get service probe -o jsonpath='{.spec.selector.app}')"
[ "$selector" = "probe" ] || fail "the Service selector app is '$selector', expected 'probe'"
addresses="$(kubectl -n starfleet get endpoints probe -o jsonpath='{.subsets[*].addresses[*].ip}')"
[ -n "$addresses" ] || fail "the Service has no endpoint addresses"
pods="$(kubectl -n starfleet get deployment probe -o jsonpath='{.spec.template.metadata.labels.app}')"
[ "$pods" = "probe" ] || fail "the probe pod labels were changed"
pass "the Service has backends"
