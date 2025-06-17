#!/bin/bash

# Author Ian Flanagan Tricentis 2025

# Set path to Java function classes
FUNCTIONS_DIR=$(pwd)

# Check if directory exists
if [ ! -d "$FUNCTIONS_DIR" ]; then
  echo "❌ Functions directory not found: $FUNCTIONS_DIR"
  exit 1
fi

# Select 2 random .java files
selected_files=($(find "$FUNCTIONS_DIR" -maxdepth 1 -name "*.java" | sort -R | head -n 2))

if [ ${#selected_files[@]} -eq 0 ]; then
  echo "⚠️ No Java function files found in $FUNCTIONS_DIR"
  exit 0
fi

echo "🔀 Randomly selected files:"
for file in "${selected_files[@]}"; do
  echo " - $(basename "$file")"
done
echo ""

# Modify and show diffs
for file in "${selected_files[@]}"; do
  class_name=$(basename "$file" .java)
  new_comment="// Function class: $class_name - Updated automatically"
  tmp_file=$(mktemp)

  {
    echo "$new_comment"
    # Add period to println if missing before quote
    sed -E 's/(System\.out\.println\(".*[^.!?])"(\);)/\1."\\2/' "$file"
  } > "$tmp_file"

  # Only overwrite if file actually changed
  if ! diff -q "$file" "$tmp_file" > /dev/null; then
    echo "✅ Updated: $class_name"
    echo "🔄 Changes:"
    diff --unified "$file" "$tmp_file" | sed 's/^/    /'
    mv "$tmp_file" "$file"
  else
    echo "ℹ️  No changes needed: $class_name"
    rm "$tmp_file"
  fi

  echo ""
done

