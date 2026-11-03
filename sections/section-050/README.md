---
draft: true
exam_objectives:
- Datapath Models
---
# Datapath Models

This section explains the datapath models of Cilium. It covers overlay routing with VXLAN and Geneve, native routing with direct node routes, BGP and masquerading, and how to choose and describe a datapath model, including kube-proxy replacement.

Each module has a landing page, two reading parts and a summary. The readings are written for the exam domain and use a private playground for hands-on steps. Each module has one graded lab, and the section ends with a capstone lab and a knowledge check.

## Modules

**Overlay Routing**

- Explain encapsulation and why an overlay needs no knowledge of pod addresses in the node network.
- Describe the path of a packet between pods on two nodes in tunnel mode.
- Name the two tunnel protocols and their default ports.
- Calculate the effect of encapsulation overhead on the pod MTU.
- Read the routing settings of a cluster and find the nodes of two pods.

**Native Routing**

- State what native routing requires from the network.
- Name the settings that select native routing and what each one means.
- Explain what `auto-direct-node-routes` does and when it works.
- Describe the alternatives for route distribution such as BGP and cloud routes.
- Explain masquerading and which destinations it applies to.

**Comparing Datapath Models**

- Compare tunnel and native routing by overhead, requirements and visibility.
- Choose a datapath model for a given environment.
- Explain what kube-proxy replacement means.
- Explain the two ways to implement masquerading.
- Read the datapath model of a cluster from `cilium-config`.

## Labs and quiz

The labs are marked UNTESTED: they passed static checks and have not been run. The capstone lab combines the skills of the section. The quiz has single-choice questions and a pass score of 70 percent.
