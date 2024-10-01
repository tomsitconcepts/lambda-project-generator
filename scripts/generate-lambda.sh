#!/bin/bash
## YOU CAN REMOVE THIS SCRIPT AFTER SUCCESSFUL FIRST UPLOAD/BUILD/DEPLOY
# 
# Purpose: generates an AWS lambda project
# 
# $1 = name of project
# 

GENERATOR_VERSION="1.1.2"
pip install copier --quiet
pip install jinja2-strcase --quiet
# build input

USER_NAME=$(powershell.exe '$env:UserName')
echo "user_name: $USER_NAME" >input.yml
echo "generator_version: $GENERATOR_VERSION" >>input.yml
echo "project_name: $1" >>input.yml
cat input.yml
# where we executed the script from, where the copier template is
EXEC_DIR=$(echo $0 | awk '{print substr($1, 0, index($1,"/scripts/"))}')
echo "exec dir = $EXEC_DIR"
#
# NOTE: when you want to test local changes, add '-r HEAD'
# then obv remove before you do
#   git tag -a v1.X.Y -m "version 1.X.Y"
#   git push origin --tags
copier copy --trust --data-file input.yml $EXEC_DIR $1
cd $1
CURRENT_DIR=$(pwd)
echo "pwd = $CURRENT_DIR"
# post copier generation step
make onetime
