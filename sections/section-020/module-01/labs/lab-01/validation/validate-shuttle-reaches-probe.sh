#!/usr/bin/env bash
# shuttle receives HTTP 200 from the probe Service
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
for attempt in 1 2 3 4 5 6; do
  code="$(http_code starfleet shuttle http://probe.starfleet:9898/healthz)"
  [ "$code" = "200" ] && pass "shuttle reaches probe"
  sleep 5
done
fail "shuttle got HTTP '$code' from the probe Service"
