#!/usr/bin/env bash
set -euo pipefail

log_file="${1:-logs/automation.log}"
mkdir -p "$(dirname "$log_file")"

log() {
  local level="$1"
  shift
  printf '%s %-5s %s\n' "$(date '+%Y-%m-%dT%H:%M:%S%z')" "$level" "$*" |
    tee -a "$log_file"
}

log INFO "Automation started"
if command -v git >/dev/null 2>&1; then
  git_version="$(git --version 2>>"$log_file")"
  log INFO "Dependency available: $git_version"
else
  log ERROR "git is unavailable"
  exit 1
fi
log INFO "Automation completed"
