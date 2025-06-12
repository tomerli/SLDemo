#!/bin/bash  
  
# Configure Git  
git config --local user.email "action@github.com"  
git config --local user.name "GitHub Action"  
git add .  

# Extract added and removed files  
added_files=$(git status --porcelain | grep "^A" | awk '{print $2}' | xargs -I {} basename {} | sed 's/\.[^.]*$//' | paste -s -d, -)  
removed_files=$(git status --porcelain | grep "^D" | awk '{print $2}' | xargs -I {} basename {} | sed 's/\.[^.]*$//' | paste -s -d, -)  
  
# Generate commit message  
commit_message="feat:"  
if [ -n "$added_files" ]; then  
  commit_message="${commit_message} +${added_files}"  
fi  
if [ -n "$removed_files" ]; then  
  commit_message="${commit_message} | -${removed_files}"  
fi  
  
# Commit & Push
git commit -m "$commit_message"  
git push  
  
# Output commit message  
echo $commit_message  