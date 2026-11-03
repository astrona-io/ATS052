#!/usr/bin/env bash
# One ready agent runs on every node
set -uo pipefail
fail() { echo "FAIL: $*"; exit 1; }
pass() { echo "PASS: $*"; exit 0; }
http_code() { kubectl -n "$1" exec "$2" -- curl -s -m 5 -o /dev/null -w '%{http_code}' "$3" 2>/dev/null || true; }
evidence() { kubectl -n "$1" get configmap "$2" -o "jsonpath={.data['$3']}" 2>/dev/null; }
expect_equal() { [ -n "$3" ] || fail "$1: could not read the live value"; [ "$2" = "$3" ] || fail "$1: expected '$3' but found '$2'"; }
desired="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.desiredNumberScheduled}')"
ready="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}')"
updated="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.updatedNumberScheduled}')"
nodes="$(kubectl get nodes --no-headers | wc -l | tr -d ' ')"
[ "$desired" = "$nodes" ] || fail "desired agents $desired, nodes $nodes"
[ "$ready" = "$desired" ] || fail "ready agents $ready of $desired"
[ "$updated" = "$desired" ] || fail "updated agents $updated of $desired"
pass "all agents are ready and updated"
