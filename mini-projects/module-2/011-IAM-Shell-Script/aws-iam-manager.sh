#!/bin/bash

# AWS IAM Manager Script for CloudOps Solutions

IAM_USER_NAMES=("david" "james" "sarah" "maria" "john")

create_iam_users() {
  echo "Starting IAM user creation process..."
  echo "-------------------------------------"
  echo

  for user in "${IAM_USER_NAMES[@]}"; do
    echo "Creating IAM user: $user"
    aws iam get-user --user-name "$user" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      echo "User $user already exists. Skipping creation."
    else
      aws iam create-user --user-name "$user"
      if [ $? -eq 0 ]; then
        echo "Success: User $user created successfully."
      else
        echo "Error: Failed to create user $user."
      fi
    fi

    echo "Creating access key for user $user..."
    aws iam create-access-key --user-name "$user" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      echo "Success: Access key created for user $user."
    else
      echo "Error: Failed to create access key for user $user."
    fi
    echo "-------------------------------------"
  done
  echo "All users processed."
  echo "IAM user creation process completed."
  echo
}

create_admin_group() {
  echo "Creating admin group and attaching policy..."
  echo "--------------------------------------------"
  aws iam get-group --group-name "admin" >/dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Admin group already exists. Skipping creation."
  else
    aws iam create-group --group-name "admin"
    if [ $? -eq 0 ]; then
      echo "Success: Admin group created successfully."
    else
      echo "Error: Failed to create admin group."
      return 1
    fi
  fi

  echo "Attaching AdministratorAccess policy..."
  aws iam attach-group-policy --group-name "admin" --policy-arn "arn:aws:iam::aws:policy/AdministratorAccess"
  if [ $? -eq 0 ]; then
    echo "Success: AdministratorAccess policy attached"
  else
    echo "Error: Failed to attach AdministratorAccess policy"
  fi
  echo
}

add_users_to_admin_group() {
  echo "Adding users to admin group..."
  echo "------------------------------"
  for user in "${IAM_USER_NAMES[@]}"; do
    echo "Adding user $user to admin group..."
    aws iam get-user --user-name "$user" >/dev/null 2>&1
    if [ $? -eq 0 ]; then
      aws iam add-user-to-group --group-name "admin" --user-name "$user"
      if [ $? -eq 0 ]; then
        echo "Success: User $user added to admin group."
      else
        echo "Error: Failed to add user $user to admin group."
      fi
    else
      echo "Error: User $user does not exist. Skipping addition to admin group."
    fi
    echo "------------------------------"
  done
  echo "User group assignment process completed."
  echo
}

main() {
  echo "=================================="
  echo " AWS IAM Management Script"
  echo "=================================="
  echo

  if ! command -v aws &> /dev/null; then
    echo "Error: AWS CLI is not installed. Please install and configure it first."
    exit 1
  fi

  create_iam_users
  create_admin_group
  add_users_to_admin_group

  echo "=================================="
  echo " AWS IAM Management Completed"
  echo "=================================="
}

main

exit 0
