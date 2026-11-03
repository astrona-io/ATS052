# Desired State And Realised Identity (Playground)

- **Slug:** ats-052-playground-020-01
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

A CiliumNetworkPolicy `probe-from-clients` allows ingress to `probe` only from pods labelled `role: client`. The `shuttle` pod has no such label.

## Run it

```sh
astrona run -c sections/section-020/module-01/playground
astrona destroy ats-052-playground-020-01
```
