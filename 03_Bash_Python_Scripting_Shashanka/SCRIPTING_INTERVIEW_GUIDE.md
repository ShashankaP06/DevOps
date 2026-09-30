# Bash and Python DevOps Interview Guide

## Bash

**What does `#!/usr/bin/env bash` do?**
It asks the operating system to locate Bash through `PATH` and use it to run
the script.

**Why use `set -euo pipefail`?**
`-e` stops on unhandled command failures, `-u` rejects unset variables, and
`pipefail` makes a pipeline fail when any stage fails. Explicitly handled
checks may still use `if`, `||`, or saved exit codes.

**Why quote variables?**
`"$value"` prevents unwanted word splitting and wildcard expansion. This is
essential for paths containing spaces and for untrusted input.

**What are stdin, stdout, and stderr?**
They are file descriptors 0, 1, and 2. `>` replaces output, `>>` appends,
`2>` redirects errors, and `2>&1` sends errors to the stdout destination.

**What is an exit code?**
It is the numeric result of a process. Zero conventionally means success;
non-zero means a failure or special condition. CI, cron, and monitoring tools
use it to determine job status.

**What does `trap` solve?**
It registers handlers for events such as `EXIT`, `ERR`, or signals, allowing
temporary files and locks to be cleaned up reliably.

**When would you use `grep`, `sed`, `awk`, and `jq`?**
`grep` filters lines, `sed` transforms text, `awk` processes columns/records,
and `jq` safely queries structured JSON. Prefer structured parsers for
structured data.

**How do you make a script idempotent?**
Check current state before changing it, use create-if-missing operations, avoid
blind appends, and verify the final state. Re-running it should produce the
same result without damage.

**What is cron?**
Cron schedules non-interactive commands. Use absolute paths, a controlled
environment, output redirection, locking when overlap is unsafe, and monitoring
for failures.

## Python

**Why use Python for DevOps automation?**
It is portable and readable, has strong libraries for APIs/cloud SDKs, handles
structured data well, and supports testing better than large shell scripts.

**Bash or Python?**
Use Bash for short command orchestration on Unix. Choose Python when logic,
data structures, API interactions, portability, error handling, or tests grow.

**Why use a virtual environment?**
It isolates project dependencies and versions from the system Python and other
projects, improving reproducibility.

**Why use `subprocess.run` with a list?**
An argument list avoids shell parsing and injection risk. Add `check=True`,
timeouts, and captured output when appropriate; avoid `shell=True` for
untrusted input.

**How should an API client handle failures?**
Set a timeout, validate status and response data, catch expected network/JSON
errors, avoid logging secrets, retry only transient failures with backoff, and
return a meaningful exit code.

**Why use `argparse` and logging?**
`argparse` provides validated CLI inputs and help. Logging supplies levels and
consistent operational records that can be routed to monitoring systems.

**What should be tested in automation?**
Test pure decision logic, malformed input, timeouts, non-success responses,
threshold boundaries, and exit behavior. Mock external systems in unit tests
and keep a smaller set of integration tests.

## Scenario answer

For a server health checker, collect metrics with timeouts, compare them
against configurable thresholds, emit structured timestamped logs, and return
zero only when all required checks pass. Do not hard-code credentials. Package
it with tests and documentation, then run it from monitoring, CI, systemd, or
cron with alerting on non-zero exits.
