#!/usr/bin/env bash

log_file="${1:-data/application.log}"

print_section() {
  local title="$1"

  echo
  echo "=== $title ==="
}

if [[ ! -f "$log_file" ]]; then
  echo "ERROR: Log file does not exist: $log_file"
  exit 2
fi

if [[ ! -r "$log_file" ]]; then
  echo "ERROR: Log file is not readable: $log_file"
  exit 2
fi

error_count="$(grep -c ' ERROR ' "$log_file")"
warning_count="$(grep -c ' WARN ' "$log_file")"
first_timestamp="$(cut -d' ' -f1 "$log_file" | head -n 1)"
last_timestamp="$(cut -d' ' -f1 "$log_file" | tail -n 1)"

echo "Log analysis report"
echo "File: $log_file"
echo "Time range: $first_timestamp to $last_timestamp"
echo "Errors: $error_count"
echo "Warnings: $warning_count"

print_section "Errors with readable messages"
grep ' ERROR ' "$log_file" | sed 's/_/ /g'

print_section "Events by service"
awk '{print $3}' "$log_file" | sort | uniq -c | sort -nr

print_section "Unique log levels"
awk '{print $2}' "$log_file" | sort | uniq

if (( error_count > 0 )); then
  echo
  echo "CRITICAL: Errors were found in the log."
  exit 1
fi

echo
echo "OK: No errors found."
exit 0
