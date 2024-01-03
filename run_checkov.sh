#!/bin/bash

# Install Checkov
pip install --upgrade checkov

# Run Checkov on Terraform files
checkov -d .

# Save Checkov output to a file
checkov -d . -o json > checkov_output.json

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.json s3://${BUCKET_NAME}/checkov_output.json

# Optional: Fail the CI/CD pipeline if Checkov identifies any issues
if [ $? -ne 0 ]; then
  echo "Checkov found issues in your Terraform code. Please review the output."
  exit 1
else
  echo "Checkov scan passed. No issues found."
fi
