#!/bin/bash

# Print environment variables before installing Checkov
echo "Environment variables before installing Checkov:"
env
echo "PATH before installing Checkov: $PATH"

# Install Checkov
pip install --upgrade checkov

# Print environment variables after installing Checkov
echo "Environment variables after installing Checkov:"
env
echo "PATH after installing Checkov: $PATH"

# Print Checkov binary details
echo "Checkov binary details:"
which checkov

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Remove previous files from S3 bucket
aws s3 rm s3://${BUCKET_NAME} --recursive

# Run Checkov on your IaC code and generate CLI output
checkov_output=$(checkov -d .)

# Save Checkov output to a file
echo "$checkov_output" > checkov_output.txt

# Upload the Checkov report to S3
aws s3 cp checkov_output.txt s3://${BUCKET_NAME}/checkov_output.txt
