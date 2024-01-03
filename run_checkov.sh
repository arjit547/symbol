#!/bin/bash

# Print environment variables before installing Checkov
echo "Environment variables before installing Checkov:"
env
echo "PATH before installing Checkov: $PATH"

# Install Checkov
pip install checkov

# Print environment variables after installing Checkov
echo "Environment variables after installing Checkov:"
env
echo "PATH after installing Checkov: $PATH"

# Print Checkov binary details
echo "Checkov binary details:"
which checkov

# Run Checkov on your IaC code and generate text report
$(which checkov) -d . -f json > checkov_output.json

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.json s3://${BUCKET_NAME}/checkov_output.json
