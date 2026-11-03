#!/usr/bin/env bash
# shuttle reaches probe across nodes
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
probe_node="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].spec.nodeName}')"
shuttle_node="$(kubectl -n starfleet get pod shuttle -o jsonpath='{.spec.nodeName}')"
[ "$probe_node" != "$shuttle_node" ] || fail "probe and shuttle run on the same node"
for attempt in 1 2 3 4 5 6; do
  code="$(http_code starfleet shuttle http://probe.starfleet:9898/healthz)"
  [ "$code" = "200" ] && pass "shuttle reaches probe on the other node"
  sleep 5
done
fail "shuttle got HTTP '$code' from probe across nodes"
