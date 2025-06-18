#!/bin/bash

# Author: Ian Flanagan - Tricentis 2025
# Purpose: Print all System.out.println(...) lines from Java function files

FUNCTIONS_DIR=$(pwd)

if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "Directory not found: $FUNCTIONS_DIR"
  exit 1
fi

echo "📋 Extracting System.out.println lines from Java files..."
echo ""

find "$FUNCTIONS_DIR" -name "*.java" | while read -r file; do
  grep 'System\.out\.println' "$file" | while read -r line; do
    echo "File: $(basename "$file")"
    echo "Line: $line"
    echo ""
  done
done

