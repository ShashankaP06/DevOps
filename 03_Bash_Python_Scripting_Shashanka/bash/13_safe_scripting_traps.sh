#!/usr/bin/env bash
set -euo pipefail

temp_file=""
cleanup() {
  [[ -z "$temp_file" ]] || rm -f "$temp_file"
}
trap cleanup EXIT
trap 'echo "ERROR: Failed at line $LINENO" >&2' ERR

require_command() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "ERROR: Required command missing: $1" >&2
    exit 2
  }
}

require_command mktemp
require_command wc
temp_file="$(mktemp)"
printf '%s\n' "deployment=successful" "environment=staging" >"$temp_file"
echo "Temporary report has $(wc -l <"$temp_file") lines."
echo "Cleanup will run automatically on exit."
