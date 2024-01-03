#!/bin/bash

# Print environment variables before installing Checkov
echo "Environment variables before installing Checkov:"
env
echo "PATH before installing Checkov: $PATH"

# Install Checkov
curl -L https://github.com/bridgecrewio/checkov/releases/latest/download/checkov_linux_amd64 -o /usr/local/bin/checkov
chmod +x /usr/local/bin/checkov

# Print environment variables after installing Checkov
echo "Environment variables after installing Checkov:"
env
echo "PATH after installing Checkov: $PATH"

# Print Checkov binary details
echo "Checkov binary details:"
ls -l /usr/local/bin/checkov

# Run Checkov on your IaC code and generate text report
/usr/local/bin/checkov -d . -o txt -f > checkov_output.txt

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.txt s3://${BUCKET_NAME}/checkov_output.txt
