#!/usr/bin/env bash

warning_threshold="${1:-80}"

get_disk_usage() {
  local usage

  usage="$(df -P / | awk 'NR == 2 {gsub("%", "", $5); print $5}')"
  echo "$usage"
}

if ! [[ "$warning_threshold" =~ ^[0-9]+$ ]] ||
   (( warning_threshold < 1 || warning_threshold > 100 )); then
  echo "ERROR: Threshold must be a number from 1 to 100."
  exit 2
fi

current_user="$(whoami)"
host_name="$(hostname)"
kernel_version="$(uname -r)"
current_time="$(date '+%Y-%m-%d %H:%M:%S')"
disk_usage="$(get_disk_usage)"

echo "System report"
echo "-------------"
echo "User: $current_user"
echo "Host: $host_name"
echo "Kernel: $kernel_version"
echo "Time: $current_time"
echo "Root disk usage: ${disk_usage}%"
echo "Warning threshold: ${warning_threshold}%"

if (( disk_usage >= warning_threshold )); then
  echo "WARNING: Root disk usage reached the configured threshold."
  exit 1
fi

echo "OK: Root disk usage is below the configured threshold."
exit 0
