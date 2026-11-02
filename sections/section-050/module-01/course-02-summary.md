---
draft: true
exam_objectives:
- Datapath Models
---
# Summary

Overlay routing carries workload packets inside node-to-node tunnels, while native routing depends on infrastructure or host routes that reach workload addresses. Their prerequisites and visible outer packet identities differ.

MTU, masquerading and return routes can create partial failures even when small requests succeed. Neither routing model automatically grants policy permission or encrypts traffic, so evaluate those controls separately along the complete supported path.
