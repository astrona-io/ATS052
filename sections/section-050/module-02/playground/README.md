# Native Routing (Playground)

- **Slug:** ats-052-playground-050-02
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium uses native routing with `auto-direct-node-routes` set to `"false"`. No node has a route to the pod CIDR of the other node, so `shuttle` cannot reach `probe`.

## Run it

```sh
astrona run -c sections/section-050/module-02/playground
astrona destroy ats-052-playground-050-02
```
