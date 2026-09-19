#!/usr/bin/env bash

name="${1:-Shashanka}"
disk_usage="${2:-50}"

echo "Hello, $name!"
echo "Disk usage received: ${disk_usage}%"
echo "Number of arguments: $#"

if ! [[ "$disk_usage" =~ ^[0-9]+$ ]]; then
  echo "ERROR: Disk usage must be a number."
  exit 2
elif (( disk_usage >= 90 )); then
  echo "CRITICAL: Disk usage is too high."
  exit 1
elif (( disk_usage >= 75 )); then
  echo "WARNING: Disk usage is increasing."
  exit 0
else
  echo "OK: Disk usage is healthy."
  exit 0
fi
