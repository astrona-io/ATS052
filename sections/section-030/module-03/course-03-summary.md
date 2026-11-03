---
draft: true
exam_objectives:
- IP Address Management (IPAM) with Cilium
---
# Summary

Multi-pool IPAM lets a cluster keep several named address pools and lets each workload choose one. It fits environments where teams, firewalls or networks need separate address ranges.

## What you learned

A `CiliumPodIPPool` is a cluster-scoped object whose name is the pool name. It lists CIDRs and a slice size per address family. The operator gives each node slices of a pool on demand and records them per pool in the `CiliumNode`. The agent hands out single addresses from the slice of the pool that the pod selected.

The annotation `ipam.cilium.io/ip-pool` selects the pool. It works on a pod and on a namespace, and a pod annotation takes precedence. Without an annotation a pod uses the pool `default`. A name that matches no pool leaves the pod without an address.

The agent reads the annotation only when it creates the pod. A change to a namespace or a running pod does not move existing pods. A Deployment moves when its pod template changes or when it is restarted. Pools also place demands on routing: the network must carry the slices of all pools, which in the examples is done by native routing with direct node routes on one layer 2 network.

- A pool is a named range with a slice size.
- A pod annotation wins over a namespace annotation.
- The annotation is read once, at pod creation.
- Check the real pod address after you move a workload.

<!-- astrona:playground:destroy -->
