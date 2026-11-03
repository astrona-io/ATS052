---
draft: true
exam_objectives:
- Cilium Architecture
---
# Summary

Cilium does not match policy by IP address. It gives each set of relevant labels one numeric security identity and writes policy against these numbers, so a rescheduled pod keeps its access.

## What you learned

The label set of an identity comes from the labels of the pod, the labels of the namespace and the service account, minus labels that Cilium filters out because they change often. All pods with equal sets share one identity. Reserved identities with small fixed numbers stand for the local host, the outside world, other nodes, the API server and similar special peers.

`CiliumIdentity` objects store the mapping from a number to its labels, and every `CiliumEndpoint` reports its identity number. When the labels of a running pod change, its identity changes, and so does the policy that applies to it.

Policy exists in two forms. The objects that you write are the desired state. The agent resolves selectors to identities and writes the allowed identity, port and protocol combinations into a policy map for each selected endpoint, which is the realised state. The datapath finds the sender identity from the local endpoint, from an IP cache map or from the tunnel header, and decides by a lookup in the policy map.

- Equal relevant labels give equal identity.
- A label change on a pod changes its identity and its access.
- Compare desired policy with realised identity when a request is denied.
- Allow a short delay after a label change before you conclude that something is wrong.

<!-- astrona:playground:destroy -->
