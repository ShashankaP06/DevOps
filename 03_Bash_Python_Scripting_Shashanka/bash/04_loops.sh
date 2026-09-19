#!/usr/bin/env bash

name="${1:-Shashanka}"
disk_values=(45 80 95)
overall_status=0

echo "Hello, $name!"
echo "Checking ${#disk_values[@]} disk-usage values..."

for disk_usage in "${disk_values[@]}"; do
  echo "Checking disk usage: ${disk_usage}%"

  if (( disk_usage >= 90 )); then
    echo "CRITICAL: Disk usage is too high."
    overall_status=1
  elif (( disk_usage >= 75 )); then
    echo "WARNING: Disk usage is increasing."
  else
    echo "OK: Disk usage is healthy."
  fi

  echo "---"
done

echo "All disk checks completed."
exit "$overall_status"
