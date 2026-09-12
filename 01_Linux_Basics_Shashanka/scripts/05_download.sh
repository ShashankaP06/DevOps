#!/bin/bash
# =====================================================================
# TASK 5: Downloading Files (wget)
# =====================================================================
# Requires: sudo apt install wget   (if not already installed)
# Run: bash scripts/05_download.sh
#
# NOTE: https://example.com/sample.txt does not actually host a real
# file (example.com is a placeholder domain), so wget may report a
# 404 Not Found. That is expected -- it still proves correct wget
# usage. If your screenshot needs a successful download, uncomment
# the FALLBACK_URL line below to fetch a real, always-available file.
# =====================================================================

echo "=== TASK 5: Downloading Files ==="

URL="https://example.com/sample.txt"
# FALLBACK_URL="https://raw.githubusercontent.com/octocat/Hello-World/master/README"

echo
echo "--> Command: wget $URL -O sample.txt"
wget "$URL" -O sample.txt

echo
echo "--> Verifying downloaded file:"
ls -l sample.txt
echo "--- file content ---"
cat sample.txt

echo
echo "=== TASK 5 COMPLETE ==="
