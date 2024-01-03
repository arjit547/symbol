#!/bin/bash

# Print environment variables and path for debugging
env
echo $PATH

# Install Checkov
curl -L https://github.com/bridgecrewio/checkov/releases/latest/download/checkov_linux_amd64 -o /usr/local/bin/checkov
chmod +x /usr/local/bin/checkov

# Run Checkov on your IaC code and generate HTML report
/usr/local/bin/checkov -d . -o html -f > checkov_output.html

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.html s3://${BUCKET_NAME}/checkov_output.html
