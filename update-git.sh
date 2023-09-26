#!/bin/bash

# Set Git user information
git config --global user.email "israelfrank123@gmail.com"
git config --global user.name "israelfrank"

# Add the Docker Compose file
git add docker-compose.yml 

# Commit the changes with a message
git commit -m "Update Docker image tag" 

# Push the changes to the remote repository
git push origin "$BRANCH_NAME" 

