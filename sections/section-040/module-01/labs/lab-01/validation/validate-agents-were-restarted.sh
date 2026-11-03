#!/usr/bin/env bash
# The DaemonSet was restarted after the change
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
value="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.spec.template.metadata.annotations.kubectl\.kubernetes\.io/restartedAt}')"
[ -n "$value" ] || fail "the DaemonSet pod template has no restartedAt annotation, so the agents were not restarted"
pass "the DaemonSet was restarted"
