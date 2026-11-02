---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Cilium's Role In Kubernetes Networking

Kubernetes defines workload and networking APIs, but a network implementation must provide the actual packet behavior. Cilium supplies Pod networking, policy enforcement and related capabilities using node agents and an eBPF-based datapath, with proxies where higher-level processing requires them. Its role should be understood through the operations it performs rather than a single broad label such as network security.

## Connect Pod Lifecycle To Networking

When a runtime prepares a Pod's network environment, the CNI lifecycle invokes the configured plugin. Cilium's CNI integration coordinates with the node agent to establish the endpoint's networking. Address allocation, interfaces and datapath state must fit the deployment's selected model. An API object existing in Kubernetes does not by itself create usable packet paths.

An endpoint represents a managed workload networking identity and state within Cilium. Its address can change when a workload is replaced, while labels can preserve the workload's policy meaning. This separation helps express security relationships through identity rather than maintaining an allowlist of every temporary Pod address.

## Separate The Networking Responsibilities

Pod routing carries traffic between workload addresses. Service handling translates a stable Service-facing destination into selected backends under the implementation's load-balancing behavior. Policy determines whether an otherwise routable operation is permitted. A connection can fail at any of these responsibilities, and success at one does not establish the others.

For example, direct traffic to a Pod may work while a Service fails because its selector has no ready endpoints or its port mapping is incorrect. Conversely, a Service can select correct backends while policy denies the caller. Trace the declared relationship and actual packet path before assuming every timeout is a routing defect.

## Identity Adds Policy Context

Cilium associates security-relevant labels with identities and uses that context for supported policy decisions. The identity is not the same as a Kubernetes ServiceAccount credential. Network permission does not grant API authority, and API RBAC does not automatically allow an application connection. The two controls protect different operations.

Labels must be protected and consistently applied because policies depend on their meaning. A broad selector can include unintended workloads, while a missing required label can leave a workload outside the intended policy. Review namespace scope and source or destination identity as well as ports and protocols.

## Observation Is Another Responsibility

Hubble provides flow observations and related visibility from Cilium. Those observations can help identify source and destination, verdict and supported protocol context. Visibility depends on enabled collection, observation points and retention. A forwarded flow does not guarantee that the application accepted the request or returned a correct result.

Higher-level features can include ingress, Gateway API support, transparent encryption and Cluster Mesh. They require configuration and supported prerequisites. Installing Cilium does not automatically enable every feature or remove the need for application TLS, infrastructure routing and appropriate Kubernetes resources.

## Use A Layered Mental Model

For a failed request, identify the client and destination, discovery result, Service selection, routing path, policy decision and application listener. Use observations relevant to the first demonstrated failure. This keeps corrections focused and avoids weakening unrelated protection merely because another relationship is broken. The network implementation connects these responsibilities, but each still has its own contract and evidence.

## Common pitfalls

> [!WARNING]
> Pod connectivity, Service selection and policy permission are separate facts. Cilium capabilities depend on enabled configuration, and network identity does not grant Kubernetes API authority.
