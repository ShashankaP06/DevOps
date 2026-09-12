#!/bin/bash
# =====================================================================
# TASK 7: Working with Environment Variables (export)
# =====================================================================
# IMPORTANT: "export" only affects the current shell and its children.
# If you run this file with "bash scripts/07_env_vars.sh", MY_VAR will
# NOT be visible afterwards in your main terminal, because the script
# runs in a child process. For your screenshot, it is best to also
# type these two lines DIRECTLY into your terminal (not via the script):
#
#   export MY_VAR="Hello, Linux!"
#   echo $MY_VAR
#
# Run this file: bash scripts/07_env_vars.sh
# =====================================================================

echo "=== TASK 7: Working with Environment Variables ==="

echo
echo "--> Command: export MY_VAR=\"Hello, Linux!\""
export MY_VAR="Hello, Linux!"

echo
echo "--> Command: echo \$MY_VAR"
echo "$MY_VAR"

echo
echo "--> Confirming it is registered as an environment variable:"
env | grep MY_VAR

echo
echo "=== TASK 7 COMPLETE ==="
