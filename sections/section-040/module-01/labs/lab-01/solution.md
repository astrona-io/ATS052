---
draft: true
exam_objectives:
- Cilium Component Roles
---
# Change Agent Settings And Restart The Agents: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-040-01-01)"
```

## Step 1: Change the setting

The agent reads `cilium-config` when it starts. A change in the ConfigMap alone does not reach a running agent.

```sh
kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.debug}{"\n"}'
kubectl -n kube-system patch configmap cilium-config --type merge -p '{"data":{"debug":"true"}}'
```

## Step 2: Restart the agents

A rollout restart adds an annotation to the pod template of the DaemonSet. The DaemonSet controller then replaces the agent pods one node at a time.

```sh
kubectl -n kube-system rollout restart daemonset/cilium
kubectl -n kube-system rollout status daemonset/cilium --timeout=300s
```

## Step 3: Check the result

```sh
kubectl -n kube-system get pods -l k8s-app=cilium -o wide
kubectl -n kube-system get daemonset cilium
```

Every node shows one ready agent pod. Submit with `astrona submit -c sections/section-040/module-01/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-040-01-01`.

## Common pitfalls

> [!WARNING]
> A ConfigMap value must be a string. Write `"true"` in quotes inside the JSON patch. Restarting the agents briefly interrupts new endpoint setup on the node, so a restart belongs in a controlled change, not a casual test.
