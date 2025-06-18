#!/bin/bash

# Author: Ian Flanagan Tricentis 2025

REPO_DIR=$(pwd)
FUNCTIONS_DIR="$REPO_DIR/src/main/java/com/tricentis/swan/station/functions"

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

# Timestamp comment
timestamp="// Updated by GitHub Actions on $(date -u +"%Y-%m-%dT%H:%M:%SZ")"

# Process each selected file
for file in "${java_files[@]}"; do
  # Normalize System.out.println punctuation
  sed -i -E 's|(System\.out\.println\("function[[:alnum:]_]+ executed)\.*("\s*;)|\1.\2|' "$file"

  # Add or update the timestamp comment at the top
  tmp_file=$(mktemp)
  awk -v ts="$timestamp" '
    NR == 1 && /^\/\/ Updated by GitHub Actions on/ { print ts; next }
    NR == 1 { print ts; print; next }
    { print }
  ' "$file" > "$tmp_file" && mv "$tmp_file" "$file"

  echo " Updated: $(basename "$file" .java)"
done

echo ""
echo "Done updating 2 function classes."
