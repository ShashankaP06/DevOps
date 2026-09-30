# Module 03 Notes — Bash and Python Automation

## Setup

```bash
sudo apt update
sudo apt install -y jq curl python3 python3-venv
python3 -m venv .venv
source .venv/bin/activate
```

A virtual environment isolates a project's Python packages. This module uses
only Python's standard library, so no third-party package installation is
required.

## Bash lessons

- `01`–`04`: variables, arguments, conditions, and loops form the control flow
  used by deployment scripts.
- `05`–`07`: functions, retries, command substitution, and system metrics make
  reusable operational checks.
- `08`–`10`: file tests, process/service checks, and text processing validate
  prerequisites and analyse logs.
- `11_json_processing.sh`: uses `jq` to read deployment/API JSON.
- `12_logging_redirection.sh`: records timestamped output with `tee`; `>`, `>>`,
  `2>`, and `2>&1` control stdout and stderr.
- `13_safe_scripting_traps.sh`: strict mode catches unset variables and failed
  pipelines; `trap` removes temporary resources even when a script fails.
- `health_check.sh`: combines configurable disk, memory, process, and URL
  checks. Exit `0` means healthy and exit `1` means unhealthy, which allows CI
  or monitoring software to make decisions.

Run from the module directory:

```bash
chmod +x bash/*.sh
./bash/11_json_processing.sh
./bash/12_logging_redirection.sh
./bash/13_safe_scripting_traps.sh
./bash/health_check.sh
echo $?
```

## Cron

Cron runs commands on a schedule. Review and replace `/path/to/...` in
`cron/health-check.cron`, then install it with:

```bash
crontab cron/health-check.cron
crontab -l
```

## Python lessons

- `automation_basics.py` covers variables, collections, functions, loops,
  conditions, files, JSON, exceptions, type hints, and logging.
- `command_runner.py` uses `argparse` and safely invokes allow-listed system
  commands with `subprocess` (no `shell=True`).
- `api_health_checker.py` calls a REST API, parses JSON, handles network
  failures, and communicates health with an exit code.
- `test_automation.py` demonstrates repeatable unit tests.

```bash
python3 python/automation_basics.py
python3 python/command_runner.py git-version
python3 python/api_health_checker.py
python3 -m unittest discover -s python -v
```

## Industry use

These patterns are used in CI/CD jobs, VM bootstrap scripts, container
entrypoints, deployment validation, monitoring probes, log analysis, scheduled
maintenance, and incident-response tooling. Credentials must come from a secret
manager or protected environment variables—not source code.
