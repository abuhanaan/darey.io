#!/bin/bash
AWS_PROFILE=$1
# Function to check if AWS profile is set
check_aws_profile() {
  if [ -z "$AWS_PROFILE" ]; then
  echo "AWS profile environment variable is not set."
  return 1
  elif ! aws configure list-profiles | grep -q "$AWS_PROFILE"; then
  echo "AWS profile '$AWS_PROFILE' does not exist."
  return 1
  else
  echo "AWS profile '$AWS_PROFILE' is set and valid."
  return 0
  fi
}

check_aws_profile $AWS_PROFILE
if [ $? -ne 0 ]; then
  echo "Exiting script due to AWS profile check failure."
  exit 1
fi
# Function to check if AWS CLI is installed

