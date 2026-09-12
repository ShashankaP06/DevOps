#!/bin/bash
# =====================================================================
# TASK 2: Viewing File Contents (cat, head, tail)
# =====================================================================
# Run: bash scripts/02_view_files.sh
# =====================================================================

echo "=== TASK 2: Viewing File Contents ==="

echo
echo "--> Command: cat /etc/passwd   (display full file)"
cat /etc/passwd

echo
echo "--> Command: head -n 5 /etc/passwd   (first 5 lines)"
head -n 5 /etc/passwd

echo
echo "--> Command: tail -n 5 /etc/passwd   (last 5 lines)"
tail -n 5 /etc/passwd

echo
echo "=== TASK 2 COMPLETE ==="
