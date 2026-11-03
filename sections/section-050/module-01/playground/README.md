# Overlay Routing With VXLAN (Playground)

- **Slug:** ats-052-playground-050-01
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium uses overlay (tunnel) routing with VXLAN. `probe` runs on the worker node and `shuttle` on the control-plane node.

## Run it

```sh
astrona run -c sections/section-050/module-01/playground
astrona destroy ats-052-playground-050-01
```
