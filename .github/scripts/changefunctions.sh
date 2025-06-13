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

# Add comment to each selected file
for file in "${selected_files[@]}"; do
  class_name=$(basename "$file" .java)
  new_comment="// Functi_

