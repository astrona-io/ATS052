# Service Selection And Policy Failures (Playground)

- **Slug:** ats-052-playground-010-02
- **Type:** Astrona playground. A clean environment with no task and no grading. UNTESTED: static checks only.

The Service `probe` selects pods with the label `app: probe-api`, but the pods carry `app: probe`. No network policy exists.

## Run it

```sh
astrona run -c sections/section-010/module-02/playground
astrona destroy ats-052-playground-010-02
```
