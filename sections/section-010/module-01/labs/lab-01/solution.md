---
draft: true
exam_objectives:
- Understand the Role of Cilium in Kubernetes Environments
---
# Record What Cilium Runs On The Cluster: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-010-01-01)"
```

## Step 1: Read the agent image and the ready count

The DaemonSet `cilium` runs one agent pod on every node. A jsonpath filter selects the container by name, so the order of containers does not matter.

```sh
kubectl -n kube-system get daemonset cilium -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-agent")].image}'
kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}'
```

## Step 2: Read the identity of the drifter

Cilium creates one CiliumEndpoint object for each Pod it manages. The security identity is in `status.identity.id`.

```sh
kubectl -n outpost get ciliumendpoint drifter -o jsonpath='{.status.identity.id}'
```

## Step 3: Save the report

Use the three values as they are printed. This command reads them again and writes the ConfigMap in one step.

```sh
kubectl -n starfleet create configmap cni-evidence \
  --from-literal=agent-image="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.spec.template.spec.containers[?(@.name=="cilium-agent")].image}')" \
  --from-literal=ready-agents="$(kubectl -n kube-system get daemonset cilium -o jsonpath='{.status.numberReady}')" \
  --from-literal=drifter-identity="$(kubectl -n outpost get ciliumendpoint drifter -o jsonpath='{.status.identity.id}')"
```

Submit with `astrona submit -c sections/section-010/module-01/labs/lab-01`. When you finish, remove the environment with `astrona destroy ats-052-lab-010-01-01`.

## Common pitfalls

> [!WARNING]
> Do not type the identity from memory: a new Pod can receive a different number. If `kubectl get ciliumendpoint` says the resource type is unknown, the Cilium CRDs are not installed and Cilium is not the network plugin.
