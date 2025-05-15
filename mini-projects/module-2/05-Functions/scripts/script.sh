#!/bin/bash

# Environment variables
ENVIRONMENT=$1

check_num_of_args() {
  # Checking the number of arguments
  if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <environment>"
  exit 1
  fi
}

check_num_of_args "$#"

# Acting based on the argument value
if [ "$ENVIRONMENT" == "local" ]; then
  echo "Running script for Local Environment..."
elif [ "$ENVIRONMENT" == "testing" ]; then
  echo "Running script for Testing Environment..."
elif [ "$ENVIRONMENT" == "production" ]; then
  echo "Running script for Production Environment..."
else
  echo "Invalid environment specified. Please use 'local', 'testing', or 'production'."
  exit 2
fi
