# 03 — Bash & Python Scripting for Automation

**Est. time:** 4 weeks @ 2-5 hrs/week
**Status:** ✅ Complete

## Why this matters for you

Test automation scripting gives you a head start here. The goal now is
*infrastructure/ops* scripting: log parsing, health checks, deployment
helpers, and small CLI tools — the glue that holds a DevOps pipeline together.

## Topics Checklist

- [x] Bash: variables, loops, conditionals, functions, exit codes
- [x] Bash: piping/redirection, `awk`, `sed`, `jq` for log/JSON processing
- [x] Writing idempotent, safe scripts (`set -euo pipefail`, trap/cleanup)
- [x] Python: virtualenvs, HTTP clients, `subprocess`, `argparse`
- [x] Python: writing a simple CLI tool with `argparse`
- [x] Interacting with REST APIs from a script (e.g. hitting a health-check
      endpoint, calling the GitHub API)
- [x] Basic cron / scheduled task automation

## Free Resources

- [Bash scripting cheat sheet — devhints.io](https://devhints.io/bash)
- [Google's Shell Style Guide](https://google.github.io/styleguide/shellguide.html)
- [Automate the Boring Stuff with Python](https://automatetheboringstuff.com/) (free online)
- [Real Python — Python CLI tutorials](https://realpython.com/command-line-interfaces-python-argparse/)

## Hands-on Mini Project

Write a small **"server health checker"**:
- A Bash script that checks disk space, memory, and whether a given process
  is running, and exits non-zero with a clear message if something's wrong.
- A Python script that hits a public API (e.g. `https://api.github.com`),
  parses the JSON response, and prints a formatted summary.
- Bonus: schedule the Bash script with `cron` and log output to a file.

Save both scripts + a `NOTES.md` explaining what each does in this folder.

## Completed work

- 13 cumulative Bash lessons plus `bash/health_check.sh`
- Python fundamentals, safe subprocess automation, REST API checker, and tests
- Cron example, genuine command-output evidence, operational notes, and an
  interview guide

See [`NOTES.md`](./NOTES.md) for commands and industry use cases.
