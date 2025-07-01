#!/bin/bash

# Environment variable for environment selection
ENVIRONMENT=$1

# Function to check the number of arguments
check_num_of_args() {
    # Checking the number of arguments
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <environment>"
        exit 1
    fi
}

# Function to activate infrastructure environment
activate_infra_environment() {
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
}

# Function to check if AWS CLI is installed
check_aws_cli() {
    if ! command -v aws &> /dev/null; then
        echo "AWS CLI is not installed. Please install it before proceeding."
        exit 1
    fi
}

# Function to check if AWS profile is set
check_aws_profile() {
    if [ -z "$AWS_PROFILE" ]; then
        echo "AWS profile environment variable is not set."
        exit 1
    fi
}

# Function to create EC2 Instances
create_ec2_instances() {
    # Specify the parameters for the EC2 instances
    instance_type="t3.micro"
    ami_id="ami-00c8ac9147e19828e"
    count=2  # Number of instances to create
    region="eu-north-1" # Region to create cloud resources
    key_name="darey"

    # Create the EC2 instances
    aws ec2 run-instances \
        --image-id "$ami_id" \
        --instance-type "$instance_type" \
        --count $count \
        --key-name "$key_name" \
        --region "$region" > ec2_output.json

    # Check if the EC2 instances were created successfully
    if [ $? -eq 0 ]; then
        echo "EC2 instances created successfully."
    else
        echo "Failed to create EC2 instances."
    fi
}

# Function to create S3 buckets for different departments
create_s3_buckets() {
    # Define a company name as prefix
    account_id=$(aws sts get-caller-identity --query Account --output text)
    company="datawise"
    # Array of department names
    departments=("marketing" "sales" "hr" "operations" "media")
    region="eu-north-1"  # Set your AWS region here

    # Loop through the array and create S3 buckets for each department
    for department in "${departments[@]}"; do
        bucket_name="${company}-${department}-data-bucket-${account_id}"
        # Create S3 bucket using AWS CLI
        aws s3api create-bucket --bucket "$bucket_name" --region "$region" --create-bucket-configuration LocationConstraint="$region"
        if [ $? -eq 0 ]; then
            echo "S3 bucket '$bucket_name' created successfully."
        else
            echo "Failed to create S3 bucket '$bucket_name'."
        fi
    done
}

# Main script execution
check_num_of_args "$@"
activate_infra_environment
check_aws_cli
check_aws_profile
create_ec2_instances
create_s3_buckets