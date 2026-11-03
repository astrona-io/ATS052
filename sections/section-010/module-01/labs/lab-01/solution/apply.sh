#!/usr/bin/env bash
# Reference solution. Run only by `astrona test`.
set -euo pipefail
agent_image="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-agent")].image}')"
ready_agents="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}')"
drifter_identity="$(kubectl -n outpost get ciliumendpoint drifter -o jsonpath='{.status.identity.id}')"
kubectl -n starfleet create configmap cni-evidence --from-literal=agent-image="$agent_image" --from-literal=ready-agents="$ready_agents" --from-literal=drifter-identity="$drifter_identity" --dry-run=client -o yaml | kubectl apply -f -
