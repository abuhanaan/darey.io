#!/bin/bash

# Function to check if AWS CLI is installed
check_aws_cli() {
  if ! command -v aws &> /dev/null; then
  echo "AWS CLI is not installed. Please install it before proceeding."
  return 1    
  fi
}
