---
draft: true
exam_objectives:
- Cilium Architecture
---
# Summary

Cilium's control components translate discovered and declared state into local forwarding, policy and service behavior. eBPF programs execute at supported hooks using map state, while proxies provide selected application-layer processing.

A control-plane disruption can leave some existing traffic functioning while new state fails to converge. Diagnose desired state, agent reconciliation and actual datapath behavior separately, including kernel and proxy prerequisites.
