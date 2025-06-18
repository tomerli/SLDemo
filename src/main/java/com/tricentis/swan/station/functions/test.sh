#!/bin/bash

# Loop through all files ending with .java in the current directory
for file in *.java; do
    # Check if the file exists
    if [ -f "$file" ]; then
        # Use grep to find lines containing "System.out.println"
        # and print the filename followed by the matched line
        grep "System.out.println" "$file" /dev/null
    fi
done

