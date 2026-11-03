#!/usr/bin/env bash
# The report names the nodes of probe and shuttle
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
probe_node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')"
shuttle_node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')"
expect_equal "probe-node" "$(evidence starfleet overlay-evidence probe-node)" "$probe_node"
expect_equal "shuttle-node" "$(evidence starfleet overlay-evidence shuttle-node)" "$shuttle_node"
pass "node placement matches"
