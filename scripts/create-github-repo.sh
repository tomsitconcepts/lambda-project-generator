#!/bin/bash
## YOU CAN REMOVE THIS SCRIPT AFTER SUCCESSFUL FIRST UPLOAD/BUILD/DEPLOY
# 
# Purpose: creates a gitHUB repo, taking the name from the directory it is in
# 
# TODO: figure out how to get creds from local environment instead...
USERNAME=tmoeller-pickup
TOKEN=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
# TODO: change this to the real shared one
ORG=tomsitconcepts
#
REPO_NAME=$(pwd | awk -F/ {'print $NF'})
echo "repo_name = $REPO_NAME"
# build POST data payload for api
ls
cat scripts/create-api.json.template | sed "s/__REPO_NAME__/$REPO_NAME/g" |
    sed "s/__ORG__/$ORG/g" |
    sed "s/__VERSION__/$1/g" |
    sed "s/__USER__/$2/g" >create-api.json
# create the repo in the cloud via api
# https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#create-an-organization-repository
curl -L \
  -X POST \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/$ORG/repos \
  -d @create-api.json
# connect the new cloud repo to our local stuff
git init .
git branch -M main
git remote add origin https://$USERNAME:$TOKEN@github.com/$ORG/$REPO_NAME.git
git add .
git commit -m "Initial commit"
# reunite them in the cloud
git push -u origin main
