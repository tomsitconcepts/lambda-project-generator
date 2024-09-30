#!/bin/bash
## YOU CAN REMOVE THIS SCRIPT AFTER SUCCESSFUL FIRST UPLOAD/BUILD/DEPLOY
# 
# Purpose: creates a git codecommit (AWS) repo, taking the name from the directory it is in
# 
REPO_NAME=$(pwd | awk -F/ {'print $NF'})
echo "repo_name = $REPO_NAME"
aws codecommit create-repository --repository-name $REPO_NAME
git init .
git branch -m master main
git remote add origin codecommit://$REPO_NAME
git add .
git commit -m "Initial commit"
git push -u origin main
# add repo-tags
REPO_ARN=$(aws codecommit get-repository --repository-name $REPO_NAME --query 'repositoryMetadata.Arn' --output text)
aws codecommit tag-resource --resource-arn $REPO_ARN --tags "PROJECT_GENERATOR=codecommit://lambda-project-generator --branch v$1"
aws codecommit tag-resource --resource-arn $REPO_ARN --tags "CREATOR=$2"
