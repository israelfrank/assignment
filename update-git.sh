#!/bin/bash

# Set Git user information
git config --global user.email "israelfrank123@gmail.com"
git config --global user.name "israelfrank"

# Get the current branch
current_branch=$(git rev-parse --abbrev-ref HEAD)
echo $current_branch
echo $BRANCH_NAME
# Check if the current branch is not the same as the target branch
if [ "$current_branch" != "$BRANCH_NAME" ]; then
  git checkout "$BRANCH_NAME" 
fi

# Add the Docker Compose file
git add docker-compose.yml 

# Commit the changes with a message
git commit -m "Update Docker image tag" 

# Push the changes to the remote repository
git push origin "$BRANCH_NAME" 

