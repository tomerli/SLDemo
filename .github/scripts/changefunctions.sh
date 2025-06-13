#!/bin/bash

# Author: Ian Flanagan Tricentis 2025

# Set paths relative to repo
REPO_DIR=$(pwd)
FUNCTIONS_DIR="$REPO_DIR/src/main/java/com/tricentis/swan/station/functions"

# Validate functions directory
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "❌ Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Process all .java files
java_files=($(find "$FUNCTIONS_DIR" -maxdepth 1 -name "*.java"))

if [ ${#java_files[@]} -eq 0 ]; then
  echo "No Java function files found in $FUNCTIONS_DIR"
  exit 0
fi

echo "Processing files in $FUNCTIONS_DIR:"
for file in "${java_files[@]}"; do
  echo " - $(basename "$file")"
  
  # First, remove a period before the closing quote, if present
  sed -i 's/\(System\.out\.println(".* executed\)\.\("\s*;\)/\1\2/g' "$file"

  # Next, add a period before the closing quote if missing
  sed -i 's/\(System\.out\.println(".* executed\)"\s*;\)/echoed;/' "$file"
  sed -i 's/\(System\.out\.println(".* executed\)"\s*;\)/\1\./g' "$file"
done

echo "✅ Done updating punctuation in System.out.println lines."
