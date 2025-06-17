#!/bin/bash

# Author: Ian Flanagan Tricentis 2025

REPO_DIR=$(pwd)
FUNCTIONS_DIR=$(pwd)

# Validate functions directory
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Select 2 random Java files
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

# Process each selected file
for file in "${java_files[@]}"; do
  # Fix System.out.println punctuation issues

  # Remove period after 'executed' if present
  sed -i '' -E 's/(System\.out\.println\("function[[:alnum:]_]+ executed)"\.\)/\1")/' "$file"

  # Add period if missing
  sed -i '' -E 's/(System\.out\.println\("function[[:alnum:]_]+ executed)"\)/\1.")/' "$file"

  echo "✅ Updated: $(basename "$file" .java)"

done 
echo ""
echo "✅ Done updating ${#java_files[@]} function class(es)."

