#!/usr/bin/env bash

target_path="${1:-bash/07_system_metrics.sh}"
overall_status=0

report_path_type() {
  local path="$1"

  if [[ -f "$path" ]]; then
    echo "Type: regular file"
  elif [[ -d "$path" ]]; then
    echo "Type: directory"
  else
    echo "Type: another filesystem object"
  fi
}

echo "Inspecting path: $target_path"

if [[ ! -e "$target_path" ]]; then
  echo "ERROR: Path does not exist."
  exit 2
fi

report_path_type "$target_path"

if [[ -r "$target_path" ]]; then
  echo "Readable: yes"
else
  echo "Readable: no"
  overall_status=1
fi

if [[ -w "$target_path" ]]; then
  echo "Writable: yes"
else
  echo "Writable: no"
  overall_status=1
fi

if [[ -x "$target_path" ]]; then
  echo "Executable/traversable: yes"
else
  echo "Executable/traversable: no"
  overall_status=1
fi

if (( overall_status == 0 )); then
  echo "OK: All required access checks passed."
else
  echo "WARNING: One or more access checks failed."
fi

exit "$overall_status"
