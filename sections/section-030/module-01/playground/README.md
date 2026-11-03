# Cilium IPAM Modes (Playground)

- **Slug:** ats-052-playground-030-01
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium runs in `cluster-pool` IPAM mode with the pool `10.100.0.0/16` and a per-node mask size of 24. No evidence report exists.

## Run it

```sh
astrona run -c sections/section-030/module-01/playground
astrona destroy ats-052-playground-030-01
```
