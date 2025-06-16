#!/bin/bash

echo "🔍 Scanning for 'executed!' in System.out.println statements..."

# Find all .java files in the current directory
java_files=($(find . -maxdepth 1 -name "Function*.java"))

if [ ${#java_files[@]} -eq 0 ]; then
  echo "⚠️ No Java function files found."
  exit 0
fi

for file in "${java_files[@]}"; do
  tmp_file=$(mktemp)

  # Remove '!' after 'executed' in System.out.println
  sed -E 's/(System\.out\.println\(".*executed)!/\1/' "$file" > "$tmp_file"

  # Only overwrite if changed
  if ! cmp -s "$file" "$tmp_file"; then
    mv "$tmp_file" "$file"
    echo "✅ Fixed: $(basename "$file")"
  else
    rm "$tmp_file"
  fi
done

echo ""
echo "🎉 Done scanning and fixing all function classes."

