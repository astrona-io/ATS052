---
draft: true
exam_objectives:
- Cilium Architecture
---
# Summary

Every pod that Cilium manages has an endpoint, which is the agent's record of its interface, addresses, identity, policy state and loaded programs. The Kubernetes API shows the intent, and the agent and the kernel show what is in effect.

## What you learned

The endpoint ID is a number that is unique only on one node, and it changes when a pod is recreated. The security identity is shared by all pods with the same relevant labels and stays the same across recreation. The `CiliumEndpoint` object has the name and namespace of the pod and publishes the endpoint ID, the identity, the state and the addresses in its status.

An endpoint moves from waiting states through regeneration to `ready`, and it regenerates when something that its programs depend on changes. During a regeneration, the previous programs keep handling traffic.

The agent tool `cilium-dbg` runs inside the agent pod of the right node. It shows the agent status, the endpoint list, the identity list, the IP cache and the policy map of each endpoint. The monitor prints dropped packets with the reason and the identity numbers of source and destination. A check from the object to the identity to the policy map finds the layer where a denial comes from.

- The endpoint ID is local to a node. The identity is cluster-wide.
- Query the agent on the node that runs the pod.
- A drop event names the identity pair that lacks a rule.
- A lagging realised state looks like a wrong policy for a short time.

<!-- astrona:playground:destroy -->
