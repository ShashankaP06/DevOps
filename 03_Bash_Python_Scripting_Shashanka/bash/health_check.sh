#!/usr/bin/env bash
set -uo pipefail

disk_threshold="${DISK_THRESHOLD:-90}"
memory_threshold="${MEMORY_THRESHOLD:-90}"
process_name="${PROCESS_NAME:-bash}"
url="${HEALTH_URL:-https://api.github.com}"
log_file="${LOG_FILE:-logs/health-check.log}"
status=0

mkdir -p "$(dirname "$log_file")"
log() { printf '%s %s\n' "$(date '+%FT%T%z')" "$*" | tee -a "$log_file"; }
fail() { log "CRITICAL: $*"; status=1; }

disk_used="$(df -P . | awk 'NR==2 {gsub("%","",$5); print $5}')"
(( disk_used < disk_threshold )) && log "OK: Disk usage ${disk_used}%" ||
  fail "Disk usage ${disk_used}% (threshold ${disk_threshold}%)"

memory_used="$(free | awk '/Mem:/ {printf "%.0f", $3/$2*100}')"
(( memory_used < memory_threshold )) && log "OK: Memory usage ${memory_used}%" ||
  fail "Memory usage ${memory_used}% (threshold ${memory_threshold}%)"

pgrep -x "$process_name" >/dev/null &&
  log "OK: Process '$process_name' is running" ||
  fail "Process '$process_name' is not running"

if command -v curl >/dev/null 2>&1; then
  http_code="$(curl -Lso /dev/null -w '%{http_code}' --max-time 10 "$url")"
  [[ "$http_code" =~ ^2 ]] && log "OK: $url returned HTTP $http_code" ||
    fail "$url returned HTTP $http_code"
else
  fail "curl is required for URL checks"
fi

log "Health check finished with exit code $status"
exit "$status"
