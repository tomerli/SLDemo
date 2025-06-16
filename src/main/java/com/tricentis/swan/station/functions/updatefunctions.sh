#!/bin/bash

# Author: Ian Flanagan, Tricentis 2025

# Set paths relative to repo
REPO_DIR=$(pwd)
FUNCTIONS_DIR=$REPO_DIR

# Validate functions directory
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "❌ Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Find all .java files and select 2 randomly
java_files=($(find "$FUNCTIONS_DIR" -maxdepth 1 -name "*.java" | sort -R | head -n 2))

if [ ${#java_files[@]} -eq 0 ]; then
  echo "⚠️ No Java function files found in $FUNCTIONS_DIR"
  exit 0
fi

echo "🔀 Randomly selected files:"
for file in "${java_files[@]}"; do
  echo " - $(basename "$file")"
done
echo ""

# Process the selected files
for file in "${java_files[@]}"; do
  # Remove a period directly before the closing quote (e.g., "executed." => "executed")
  sed -i -E 's/(System\.out\.println\(".*executed)\.(\"\s*;)/\1\2/' "$file"

  # Add a period if it's missing before the closing quote (e.g., "executed" => "executed.")
  sed -i -E 's/(System\.out\.println\(".*executed)(\"\s*;)/\1.\2/' "$file"

  # Output which file was updated
  class_name=$(basename "$file" .java)
  echo "✅ Updated: $class_name"
done

echo ""
echo "🎉 Done updating 2 random function classes."

