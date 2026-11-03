---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Understand the Role of Cilium in Kubernetes Environments

This section explains what Cilium does in a Kubernetes cluster. It covers the CNI contract, the eBPF datapath that Cilium builds on each node, the path of pod and Service traffic and the way policy follows identity and not address.

Each module has a landing page, two reading parts and a summary. The readings are written for the exam domain and use a private playground for hands-on steps. Each module has one graded lab, and the section ends with a capstone lab and a knowledge check.

## Modules

**The Role Of Cilium In Kubernetes Networking**

- State the three rules of the Kubernetes network model.
- Explain what the CNI standard asks a network plugin to do when a pod starts and when it stops.
- Name the Cilium components, where each one runs and what each one does.
- Explain what eBPF is and why Cilium uses it instead of long lists of iptables rules.
- Read the Cilium agent image, the number of ready agents and the security identity of a workload from a live cluster.

**Where Cilium Acts: Services, Pods And Policy**

- Explain how a Service selector produces the endpoints that receive traffic.
- Describe how Cilium translates a Service address to a pod address.
- Tell a Service fault apart from a policy fault by reading the right objects.
- Write a CiliumNetworkPolicy that allows one port from one namespace.
- Explain why selecting a pod with a policy changes its default behaviour.

## Labs and quiz

The labs are marked UNTESTED: they passed static checks and have not been run. The capstone lab combines the skills of the section. The quiz has single-choice questions and a pass score of 70 percent.
