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

# Array to store modified files
modified_files=()

# Clear or create output file
output_file="$REPO_DIR/updated_files.txt"
> "$output_file"

# Process each selected file
for file in "${java_files[@]}"; do
  # Remove period if it exists after 'executed'
  sed -E -i '' 's/(System\.out\.println\(".*executed)\.(\"\s*;)/\1\2/' "$file"

  # Add a period if missing
  sed -E -i '' 's/(System\.out\.println\(".*executed)(\"\s*;)/\1.\2/' "$file"

  class_name=$(basename "$file" .java)
  echo "✅ Updated: $class_name"

  # Track and write just the filename (no path)
  modified_files+=("$class_name.java")
  echo "$class_name.java" >> "$output_file"
done

echo ""
echo "🎉 Done updating ${#modified_files[@]} function classes."
echo "📝 Filenames written to: $output_file"

