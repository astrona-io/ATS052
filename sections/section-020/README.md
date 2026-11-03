---
draft: true
exam_objectives:
- Cilium Architecture
---
# Cilium Architecture

This section explains how Cilium represents workloads internally. It covers security identities that come from labels, the way the datapath uses them, the endpoint that the agent creates for each pod and the difference between desired and realised state.

Each module has a landing page, two reading parts and a summary. The readings are written for the exam domain and use a private playground for hands-on steps. Each module has one graded lab, and the section ends with a capstone lab and a knowledge check.

## Modules

**Security Identities In Cilium**

- Explain how Cilium derives a security identity from the labels of a pod.
- Name the reserved identities and say what each one represents.
- Read the identity of a pod from its `CiliumEndpoint`.
- Explain why a label change on a running pod can change its access.
- Describe how an identity reaches the datapath and how a policy decision uses it.

**Endpoints And The State Of The Datapath**

- Explain what a Cilium endpoint is and how it relates to a pod and a CiliumEndpoint object.
- Read the endpoint ID, the identity and the state from a CiliumEndpoint.
- Name the main endpoint states and what causes a regeneration.
- Use `cilium-dbg` to inspect endpoints, identities and policy maps.
- Find dropped packets with the monitor command.

## Labs and quiz

The labs are marked UNTESTED: they passed static checks and have not been run. The capstone lab combines the skills of the section. The quiz has single-choice questions and a pass score of 70 percent.
