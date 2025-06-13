#!/bin/bash

# Author: Ian Flanagan Tricentis 2025

# Set paths relative to repo
REPO_DIR=$(pwd)
FUNCTIONS_DIR="$REPO_DIR/src/main/java/com/tricentis/swan/station/functions"

# Validate functions directory
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo " Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Select 2 random .java files
selected_files=($(find "$FUNCTIONS_DIR" -maxdepth 1 -name "*.java" | sort -R | head -n 2))

if [ ${#selected_files[@]} -eq 0 ]; then
  echo " No Java function files found in $FUNCTIONS_DIR"
  exit 0
fi

echo "🔀 Randomly selected files:"
for file in "${selected_files[@]}"; do
  echo " - $(basename "$file")"
done
echo ""

# Process each selected file
for file in "${selected_files[@]}"; do
  class_name=$(basename "$file" .java)
  new_comment="// Function updated automatically by script - $(date)"
  
  # Add comment to top of file (Linux sed)
  sed -i "1s|^|$new_comment\n|" "$file"

  # Modify System.out.println lines:
  # If the string ends with . before the quote, remove the dot
  sed -i 's/\(System\.out\.println.*"\)\.\("\s*;\)/\1\2/' "$file"

  # If the string ends with quote and semicolon, but no dot, add dot
  sed -i 's/\(System\.out\.println.*[^\.]"\)\(\s*;\)/\1.\2/' "$file"
done

echo "🎉 Done updating ${#selected_files[@]} function classes."
