#!/bin/bash
## YOU CAN REMOVE THIS SCRIPT AFTER SUCCESSFUL FIRST UPLOAD/BUILD/DEPLOY
# 
# Purpose: tags the AWS codecommit resource with the trunk pipeline physical id
# 
# $1 = name of project
# $2 = cloudformation name of the trunk pipeline stack
# 
echo "repo name = $1"
echo "stack name = $2"
REPO_ARN=$(aws codecommit get-repository --repository-name $1 --query 'repositoryMetadata.Arn' --output text)
echo "REPO_ARN = $REPO_ARN"
TRUNK_PIPE_NAME=$(aws cloudformation describe-stack-resources --stack-name $2 --query "StackResources[?ResourceType=='AWS::CodePipeline::Pipeline'].PhysicalResourceId" --output text)
echo "TRUNK_PIPE_NAME = $TRUNK_PIPE_NAME"
aws codecommit tag-resource --resource-arn $REPO_ARN --tags "TRUNK_CODEPIPELINE=$TRUNK_PIPE_NAME"
