# The Cilium Agent (Playground)

- **Slug:** ats-052-playground-040-01
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

Cilium agents run on both nodes with debug logging switched off (`debug: "false"` in `cilium-config`).

## Run it

```sh
astrona run -c sections/section-040/module-01/playground
astrona destroy ats-052-playground-040-01
```
