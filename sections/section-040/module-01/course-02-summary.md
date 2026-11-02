---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Summary

Cilium components own different operations. The agent manages node endpoints and datapath state, the operator coordinates selected cluster-wide work, and the CNI integration participates in Pod networking lifecycle.

Hubble server and Relay provide local and aggregated visibility, while clients present observations. Remote management and node-local debugging use different access paths; partial failures should be attributed to the responsible component rather than one overall installation status.
