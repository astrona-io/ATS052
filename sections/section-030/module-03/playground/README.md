# Multi-Pool IPAM (Playground)

- **Slug:** ats-052-playground-030-03
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium runs in `multi-pool` mode with the pools `default` (10.10.0.0/16) and `green` (10.20.0.0/16). `drifter` is a Deployment in `outpost` and takes its address from `default`.

## Run it

```sh
astrona run -c sections/section-030/module-03/playground
astrona destroy ats-052-playground-030-03
```
