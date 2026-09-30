#!/usr/bin/env bash

name="${1:-Shashanka}"
disk_values=(45 80 95)
overall_status=0

print_header() {
  local user_name="$1"

  echo "Hello, $user_name!"
  echo "Checking ${#disk_values[@]} disk-usage values..."
}

check_disk_usage() {
  local disk_usage="$1"

  echo "Checking disk usage: ${disk_usage}%"

  if (( disk_usage >= 90 )); then
    echo "CRITICAL: Disk usage is too high."
    return 1
  elif (( disk_usage >= 75 )); then
    echo "WARNING: Disk usage is increasing."
    return 0
  else
    echo "OK: Disk usage is healthy."
    return 0
  fi
}

print_header "$name"

for disk_usage in "${disk_values[@]}"; do
  if ! check_disk_usage "$disk_usage"; then
    overall_status=1
  fi

  echo "---"
done

echo "All disk checks completed."
exit "$overall_status"
