---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Summary

A request in a Cilium cluster passes three independent mechanisms: Service selection, the datapath and policy. Each mechanism has its own objects, and a fault in an early step leaves the later steps empty or unreachable.

## What you learned

A Service selector chooses ready pods, and the control plane records their addresses in EndpointSlices. If the selector matches no pod, the Service has no backends and no network plugin can fix that. Cilium watches the EndpointSlices and writes the frontend and backend entries into a kernel map. It chooses one backend for each connection, and with kube-proxy replacement it does so at `connect` time on the client socket.

Policy decides whether the traffic is allowed. A pod that no policy selects accepts all traffic. A pod that an ingress policy selects accepts only what a rule allows, and the same holds for egress. Rules name peers by labels, and the agent turns the labels into security identities and stores them in the policy map of the selected endpoint. The namespace of a pod is a label, so rules can allow a whole namespace.

CiliumNetworkPolicy and the standard NetworkPolicy both work with Cilium and are translated into the same internal rules. The Cilium object adds DNS, HTTP, deny and entity rules.

- Read the Service, the EndpointSlice, the pod labels and the CiliumEndpoint in that order.
- An empty EndpointSlice is a selection fault, not a policy fault.
- Policy is additive and is default-deny for the selected direction only.
- A policy selector and a Service selector are different things and use different labels.

<!-- astrona:playground:destroy -->
