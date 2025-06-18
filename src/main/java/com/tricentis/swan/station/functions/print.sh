#!/bin/bash

# Author: Ian Flanagan - Tricentis 2025
# Purpose: Randomly pick 2 function files and normalize System.out.println punctuation

FUNCTIONS_DIR=$(pwd)
CHANGED_FILES=()

if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "❌ Directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Find all Function*.java files and randomly pick 2
FILES=($(find "$FUNCTIONS_DIR" -name "Function*.java" | shuf -n 2))

echo "🎲 Randomly selected files:"
for f in "${FILES[@]}"; do
  echo " - $(basename "$f")"
done
echo ""

# Process each selected file
for file in "${FILES[@]}"; do
  orig_tmp=$(mktemp)
  cp "$file" "$orig_tmp"

  # Remove trailing period (if any)
  sed -i -E 's/(System\.out\.println\(".*?)(\.)(";\s*)/\1\3/' "$file"

  # Add period if missing
  sed -i -E 's/(System\.out\.println\(".*[^\.])(";\s*)/\1.\2/' "$file"

  if ! diff -q "$file" "$orig_tmp" > /dev/null; then
    CHANGED_FILES+=("$(basename "$file")")
  fi

  rm "$orig_tmp"
done

echo ""
if [ ${#CHANGED_FILES[@]} -eq 0 ]; then
  echo "✅ No changes made to selected files."
else
  echo "✅ Modified files:"
  for f in "${CHANGED_FILES[@]}"; do
    echo " - $f"
  done
fi

