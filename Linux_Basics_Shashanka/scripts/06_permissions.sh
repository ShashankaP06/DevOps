#!/bin/bash
# =====================================================================
# TASK 6: Changing Permissions (chmod)
# =====================================================================
# Run: bash scripts/06_permissions.sh
# =====================================================================

echo "=== TASK 6: Changing Permissions ==="

echo
echo "--> Command: touch secure.txt"
touch secure.txt

echo
echo "--> Permissions BEFORE chmod:"
ls -l secure.txt

echo
echo "--> Command: chmod 444 secure.txt   (read-only for owner/group/others)"
chmod 444 secure.txt

echo
echo "--> Permissions AFTER chmod:"
ls -l secure.txt

echo
echo "=== TASK 6 COMPLETE ==="
