#!/usr/bin/env bash

process_name="${1:-bash}"
service_name="${2:-}"
overall_status=0

check_process() {
  local name="$1"
  local process_ids

  if process_ids="$(pgrep -x "$name")"; then
    echo "OK: Process '$name' is running."
    echo "PID(s): $(echo "$process_ids" | tr '\n' ' ')"

    local first_pid
    first_pid="$(echo "$process_ids" | head -n 1)"
    ps -p "$first_pid" -o pid=,comm=,etime=
    return 0
  fi

  echo "CRITICAL: Process '$name' is not running."
  return 1
}

check_service() {
  local name="$1"

  if [[ -z "$name" ]]; then
    echo "INFO: No systemd service name supplied; skipping service check."
    return 0
  fi

  if ! command -v systemctl >/dev/null 2>&1; then
    echo "ERROR: systemctl is unavailable."
    return 2
  fi

  if systemctl is-active --quiet "$name"; then
    echo "OK: Service '$name' is active."
    return 0
  fi

  echo "CRITICAL: Service '$name' is not active."
  return 1
}

echo "Process and service report"
echo "--------------------------"

if ! check_process "$process_name"; then
  overall_status=1
fi

if ! check_service "$service_name"; then
  overall_status=1
fi

exit "$overall_status"
