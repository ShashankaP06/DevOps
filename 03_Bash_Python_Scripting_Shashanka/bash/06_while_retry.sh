#!/usr/bin/env bash

name="${1:-Shashanka}"
max_attempts="${2:-3}"
attempt=1

check_service() {
  local current_attempt="$1"

  if (( current_attempt >= 3 )); then
    return 0
  fi

  return 1
}

if ! [[ "$max_attempts" =~ ^[1-9][0-9]*$ ]]; then
  echo "ERROR: Maximum attempts must be a positive number."
  exit 2
fi

echo "Hello, $name!"
echo "Maximum attempts: $max_attempts"

while (( attempt <= max_attempts )); do
  echo "Attempt $attempt: checking service..."

  if check_service "$attempt"; then
    echo "OK: Service is healthy."
    exit 0
  fi

  echo "WARNING: Service is not ready."
  ((attempt++))
done

echo "CRITICAL: Service did not become healthy."
exit 1
