#!/bin/bash
# =====================================================================
# MASTER SCRIPT - runs every task in order and saves a full transcript.
#
# Usage (from a Linux/WSL terminal, inside the 01_Linux_Basics_Shashanka
# folder):
#
#   bash scripts/run_all.sh
#
# This also writes a full log to output_log.txt in the project root,
# which you can open/cat and screenshot if useful, in addition to
# screenshotting the live terminal for each task.
# =====================================================================
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR/.."

{
  bash scripts/01_create_rename.sh
  echo
  bash scripts/02_view_files.sh
  echo
  bash scripts/03_search_grep.sh
  echo
  bash scripts/04_zip_unzip.sh
  echo
  bash scripts/05_download.sh
  echo
  bash scripts/06_permissions.sh
  echo
  bash scripts/07_env_vars.sh
  echo
  echo "ALL 7 TASKS COMPLETED SUCCESSFULLY."
} 2>&1 | tee "$SCRIPT_DIR/../output_log.txt"

echo
echo "Reminder: also run the two export/echo commands from Task 7 directly"
echo "in your terminal (not just via this script) before screenshotting it,"
echo "so the environment variable demo is fully authentic."
