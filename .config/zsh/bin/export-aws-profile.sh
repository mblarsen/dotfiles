#!/usr/bin/env bash

# 
# export AWS_PROFILE=the-profile-you-want
# source ./path/to/this-script/export-aws-profile.sh
#

export AWS_ACCESS_KEY_ID=$(cat ~/.aws/credentials | grep -A1 $AWS_PROFILE | tail -n 1 | cut -d "=" -f 2)
export AWS_SECRET_ACCESS_KEY=$(cat ~/.aws/credentials | grep -A2 $AWS_PROFILE | tail -n 1 | cut -d "=" -f 2)

echo "AWS_ACCESS_KEY_ID: $AWS_ACCESS_KEY_ID"
aws sts get-caller-identity
