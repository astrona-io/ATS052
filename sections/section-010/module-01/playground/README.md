# Cilium As The Cluster Network Plugin (Playground)

- **Slug:** ats-052-playground-010-01
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Two-node kind cluster with Cilium installed as the only network plugin, plus the `probe` Service, the `shuttle` pod and the `drifter` pod. No evidence ConfigMap exists.

## Run it

```sh
astrona run -c sections/section-010/module-01/playground
astrona destroy ats-052-playground-010-01
```
