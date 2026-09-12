#!/bin/bash
# =====================================================================
# TASK 1: Creating and Renaming Files/Directories
# =====================================================================
# Run this file inside a Linux terminal (e.g. WSL / Ubuntu):
#   bash scripts/01_create_rename.sh
# =====================================================================

echo "=== TASK 1: Creating and Renaming Files/Directories ==="

echo
echo "--> Command: mkdir test_dir"
mkdir -p test_dir

echo
echo "--> Command: touch test_dir/example.txt   (create empty file)"
touch test_dir/example.txt

echo
echo "--> Contents of test_dir BEFORE rename:"
ls -l test_dir

echo
echo "--> Command: mv test_dir/example.txt test_dir/renamed_example.txt"
mv test_dir/example.txt test_dir/renamed_example.txt

echo
echo "--> Contents of test_dir AFTER rename:"
ls -l test_dir

echo
echo "=== TASK 1 COMPLETE ==="
