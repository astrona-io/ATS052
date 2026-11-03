# Comparing Datapath Models (Playground)

- **Slug:** ats-052-playground-050-03
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium uses native routing with direct node routes, no kube-proxy replacement and iptables masquerading. `shuttle` and `probe` run on different nodes.

## Run it

```sh
astrona run -c sections/section-050/module-03/playground
astrona destroy ats-052-playground-050-03
```
