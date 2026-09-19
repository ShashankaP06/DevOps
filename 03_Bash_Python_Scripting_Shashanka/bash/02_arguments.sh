#!/usr/bin/env bash

default_name="Shashanka"
default_role="DevOps Engineer"

name="${1:-$default_name}"
target_role="${2:-$default_role}"

echo "Hello, $name!"
echo "Target role: $target_role"
echo "Number of arguments: $#"
echo "All arguments: $@"
