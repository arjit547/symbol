#!/bin/bash

# Install Checkov
curl -L https://github.com/bridgecrewio/checkov/releases/latest/download/checkov_linux_amd64 -o checkov
chmod +x checkov
mv checkov /usr/local/bin/checkov

# Run Checkov on your IaC code and generate HTML report
checkov -d . -o html -f > checkov_output.html

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.html s3://${BUCKET_NAME}/checkov_output.html
