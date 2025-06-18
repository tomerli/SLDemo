#!/bin/bash

# Author: Ian Flanagan Tricentis 2025

REPO_DIR=$(pwd)
FUNCTIONS_DIR=$(pwd)

# Cross-platform in-place sed (macOS vs GNU)
function sed_inplace() {
  if [[ "$OSTYPE" == "darwin"* ]]; then
    sed -i '' "$@"
  else
    sed -i "$@"
  fi
}

# Validate directory
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Select 2 random files
java_files=($(find "$FUNCTIONS_DIR" -maxdepth 1 -name "Function*.java" | sort -R | head -n 2))

if [ ${#java_files[@]} -eq 0 ]; then
  echo "No Java function files found in $FUNCTIONS_DIR"
  exit 0
fi

echo "Randomly selected files:"
for file in "${java_files[@]}"; do
  echo " - $(basename "$file")"
done
echo ""

# Process each file
for file in "${java_files[@]}"; do
  filename=$(basename "$file" .java)
  function_name=$(echo "$filename" | tr '[:upper:]' '[:lower:]')

  # Backup file to compare later
  orig_file=$(mktemp)
  cp "$file" "$orig_file"

  # Normalize System.out.println punctuation
  sed_inplace -E "s/(System\.out\.println\(\"${function_name} executed)\.?(\"\s*;)/\1.\2/" "$file"
  

# Diff to show changes
  echo "✅ Updated: $filename.java"
  echo "🔄 Changes:"
  diff -u "$orig_file" "$file" | grep -E '^\+[^+]|^-'
  echo ""

  rm -f "$orig_file"
done

echo "✅ Done updating 2 function classes."

