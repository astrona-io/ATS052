---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Summary

Hubble is the observability layer of Cilium. It records flows, which are records of network activity with identities, names, protocol details and a verdict, and it exposes them through an API, a user interface and metrics.

## What you learned

The Hubble server is part of the agent on each node. It builds flows from datapath events and keeps recent ones in a fixed-size ring buffer in memory. It sees only the traffic of its node, and it is not a long-term store. A flow names the source and destination with labels and identity, carries the protocol details and the verdict such as forwarded or dropped, and gives the reason for a drop. Metrics give long-term counts for dashboards and alerts.

Hubble Relay is a Deployment that collects the flows of all agents and presents them through one API. It finds the agents through the Service `hubble-peer` and clients reach it through the Service `hubble-relay`. The connections can use mutual TLS. The user interface and the command-line client are clients of Relay. When Relay stops, the datapath and the agents are not affected, and only the cluster-wide view is lost.

- A flow is a datapath record with identity, names and a verdict.
- Each agent keeps only the recent flows of its own node.
- Relay merges the flows of all nodes and stores nothing.
- Clients use the Service port of `hubble-relay`.

<!-- astrona:playground:destroy -->
