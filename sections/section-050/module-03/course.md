---
draft: true
exam_objectives:
- Datapath Models
---
# Comparing Datapath Models

A cluster uses one datapath model, and the choice affects performance, visibility and what the network must provide. This module compares the models side by side, explains which settings describe the model of a cluster and shows how Cilium replaces kube-proxy and handles masquerading in each model.

Keep one sentence in mind: **read the model from the configuration, and choose it by what the network below can provide.**

The module has two parts. The first part compares tunnel and native routing and gives rules for the choice. The second part explains kube-proxy replacement and the masquerade setting, and how to read both from a running cluster.

## Learning objectives

After this module you can:

- Compare tunnel and native routing by overhead, requirements and visibility.
- Choose a datapath model for a given environment.
- Explain what kube-proxy replacement means.
- Explain the two ways to implement masquerading.
- Read the datapath model of a cluster from `cilium-config`.

## Before you start

You need Kubernetes basics, Services and kube-proxy, and the two datapath models from the earlier material.

Your playground is a two-node kind cluster with Cilium 1.20.2 in native routing mode, with the nodes in one layer 2 network.

| Namespace | Object | What it is |
| --- | --- | --- |
| `starfleet` | Deployment `probe` and Service `probe` | A small HTTP server on port 9898 |
| `starfleet` | Pod `shuttle` | A client pod with `curl` |
| `outpost` | Deployment `drifter` | A client pod with `curl` in another namespace |

Launch the playground now and keep it running while you read the parts:

<!-- astrona:playground -->
