#!/usr/bin/env bash
set -euo pipefail

json_file="${1:-data/deployment.json}"
command -v jq >/dev/null 2>&1 || {
  echo "ERROR: jq is required. Install it with: sudo apt install jq" >&2
  exit 2
}
[[ -r "$json_file" ]] || {
  echo "ERROR: Cannot read $json_file" >&2
  exit 2
}

echo "Deployment: $(jq -r '.application + ":" + .version' "$json_file")"
echo "Environment: $(jq -r '.environment' "$json_file")"
echo "Healthy services:"
jq -r '.services[] | select(.healthy) | "- \(.name) on port \(.port)"' "$json_file"
