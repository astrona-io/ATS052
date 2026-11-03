#!/usr/bin/env bash
# The pool amber has the CIDR 10.30.0.0/16 and mask size 24
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
cidr="$(kubectl get ciliumpodippool amber -o jsonpath='{.spec.ipv4.cidrs[0]}' 2>/dev/null)"
[ "$cidr" = "10.30.0.0/16" ] || fail "pool amber has the CIDR '$cidr', expected 10.30.0.0/16"
mask="$(kubectl get ciliumpodippool amber -o jsonpath='{.spec.ipv4.maskSize}')"
[ "$mask" = "24" ] || fail "pool amber has the mask size '$mask', expected 24"
pass "pool amber exists"
