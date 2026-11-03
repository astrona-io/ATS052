---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Summary

The Cilium agent does the work on every node. It runs as a DaemonSet with the host network and elevated privileges, because it must create interfaces, load kernel programs and change routes.

## What you learned

The agent answers the CNI calls, allocates pod addresses from the range of its node, creates the endpoint of each pod, resolves policy to identities, loads the eBPF programs and maps, sets up routes or tunnel devices and runs the Hubble server. It shares state with other components only through the Kubernetes API, and it offers a local socket to the CNI binary and to the `cilium-dbg` tool.

The agent reads the ConfigMap `cilium-config` once at start. A change needs a rolling restart of the DaemonSet. While the agent on a node restarts, the pinned kernel programs and maps keep the traffic of running pods flowing. New pods on that node and policy changes wait until the new agent is ready. A rolling restart limits how many nodes are without a ready agent at once.

To investigate an agent, read its log, run `cilium-dbg status` and `cilium-dbg config` in its pod and read the pod events. Always query the agent of the node you care about, because each agent knows only its own node.

- Settings take effect at agent start, not at ConfigMap change.
- A restart does not interrupt running pods, but it delays new pods.
- `cilium-dbg config` proves which values an agent runs with.
- Debug logging is a temporary tool, not a permanent setting.

<!-- astrona:playground:destroy -->
