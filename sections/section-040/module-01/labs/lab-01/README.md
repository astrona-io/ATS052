---
estimated_duration: 25m
---

# Lab: Change Agent Settings And Restart The Agents

Graded lab. **UNTESTED**: the files passed static checks only (`astrona validate`, `bash -n`). The lab has not been run, and the reference solution has not been proven.

The task is in `question.md`; the walkthrough is in `solution.md`.

## Run it

```sh
astrona run -c sections/section-040/module-01/labs/lab-01
astrona submit -c sections/section-040/module-01/labs/lab-01
astrona destroy ats-052-lab-040-01-01
```

## Checks

| Script | What it proves |
| --- | --- |
| `validate-debug-setting-enabled.sh` | The key debug in cilium-config is "true" |
| `validate-agents-were-restarted.sh` | The DaemonSet was restarted after the change |
| `validate-all-agents-ready.sh` | One ready agent runs on every node |
