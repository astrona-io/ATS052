---
draft: true
exam_objectives:
- Datapath Models
---
# Verify The Datapath Model Of A Cluster: Solution

Connect to the cluster first. A kubeconfig is the file that tells `kubectl` which cluster and credentials to use.

```sh
export KUBECONFIG="$(astrona kubeconfig ats-052-lab-050-03-01)"
```

## Step 1: Read the model

```sh
kubectl -n kube-system get configmap cilium-config -o yaml | grep -E 'routing-mode|native-routing|auto-direct|kube-proxy-replacement|enable-bpf-masquerade'
```

## Step 2: Save the report

```sh
kubectl -n starfleet create configmap datapath-model \
  --from-literal=routing-mode="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.routing-mode}')" \
  --from-literal=ipv4-native-routing-cidr="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.ipv4-native-routing-cidr}')" \
  --from-literal=auto-direct-node-routes="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.auto-direct-node-routes}')" \
  --from-literal=kube-proxy-replacement="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.kube-proxy-replacement}')" \
  --from-literal=enable-bpf-masquerade="$(kubectl -n kube-system get configmap cilium-config -o jsonpath='{.data.enable-bpf-masquerade}')"
```

## Step 3: Prove it with a request

```sh
kubectl -n starfleet get pods -o wide
kubectl -n starfleet exec shuttle -- curl -s -m 5 -o /dev/null -w '%{http_code}\n' http://probe.starfleet:9898/healthz
```

The pods are on different nodes and the request returns 200. Submit with `astrona submit -c sections/section-050/module-03/labs/lab-01` and remove the environment with `astrona destroy ats-052-lab-050-03-01`.

## Common pitfalls

> [!WARNING]
> Copy the values as strings exactly as the ConfigMap shows them, for example `false`, not `no` or `disabled`.
