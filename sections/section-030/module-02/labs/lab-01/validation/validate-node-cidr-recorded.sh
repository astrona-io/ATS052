#!/usr/bin/env bash
# The report holds the CiliumNode slice of that node
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
pod="$(kubectl -n starfleet get pods -l app=probe -o jsonpath='{.items[0].metadata.name}')"
node="$(kubectl -n starfleet get pod "$pod" -o jsonpath='{.spec.nodeName}')"
live="$(kubectl get ciliumnode "$node" -o jsonpath='{.spec.ipam.podCIDRs[0]}')"
expect_equal "node-cidr" "$(evidence starfleet address-evidence node-cidr)" "$live"
pass "node-cidr matches"
