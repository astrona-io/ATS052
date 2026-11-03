---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Cilium Component Roles

This section explains the Cilium components and what each one is responsible for. It covers the agent and its configuration, the operator and its leader election, the CNI plugin and pod creation, and Hubble with its relay.

Each module has a landing page, two reading parts and a summary. The readings are written for the exam domain and use a private playground for hands-on steps. Each module has one graded lab, and the section ends with a capstone lab and a knowledge check.

## Modules

**The Cilium Agent**

- Name the main tasks of the Cilium agent.
- Explain how the agent is deployed and why it needs elevated privileges.
- Describe where the agent reads its configuration and when it reads it.
- Explain what happens to running pods when the agent restarts.
- Read the status and the logs of an agent.

**The Operator And The CNI Plugin**

- List the tasks of the Cilium operator.
- Explain how operator leader election works and why two replicas improve availability.
- Say which functions continue and which stop when the operator is down.
- Describe how the CNI binary and its configuration get onto a node.
- Explain what happens to a new pod when the agent is not ready.

**Hubble And Hubble Relay**

- Describe what a Hubble flow contains.
- Explain where the Hubble server runs and what limits how many flows it keeps.
- Describe how Hubble Relay finds the agents and what it exposes.
- Name the Services that clients use and what each one is for.
- Restore a stopped Hubble Relay and check its Service.

## Labs and quiz

The labs are marked UNTESTED: they passed static checks and have not been run. The capstone lab combines the skills of the section. The quiz has single-choice questions and a pass score of 70 percent.
