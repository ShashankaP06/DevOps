#!/bin/bash
# =====================================================================
# TASK 4: Zipping and Unzipping
# =====================================================================
# Requires: sudo apt install zip unzip   (if not already installed)
# Run: bash scripts/04_zip_unzip.sh
# =====================================================================

echo "=== TASK 4: Zipping and Unzipping ==="

echo
echo "--> Command: zip -r test_dir.zip test_dir"
zip -r test_dir.zip test_dir

echo
echo "--> Contents of the archive (zip -sf test_dir.zip):"
unzip -l test_dir.zip

echo
echo "--> Command: unzip test_dir.zip -d unzipped_dir"
mkdir -p unzipped_dir
unzip -o test_dir.zip -d unzipped_dir

echo
echo "--> Contents of unzipped_dir:"
ls -lR unzipped_dir

echo
echo "=== TASK 4 COMPLETE ==="
