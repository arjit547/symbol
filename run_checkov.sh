#!/bin/bash

# Install Checkov
pip install --upgrade checkov

# Run Checkov on Terraform files and save the JSON output
checkov -d . -o json -f checkov_output.json

# Set your S3 bucket name
BUCKET_NAME="cerebruchecov-artifact"

# Upload the Checkov report to S3
aws s3 cp checkov_output.json s3://${BUCKET_NAME}/checkov_output.json

# Parse Checkov JSON output and format the results
PASSED_CHECKS=$(jq -r '.results.passed_checks | length' checkov_output.json)
FAILED_CHECKS=$(jq -r '.results.failed_checks | length' checkov_output.json)
SKIPPED_CHECKS=$(jq -r '.results.skipped_checks | length' checkov_output.json)

echo "terraform scan results:"
echo "Passed checks: ${PASSED_CHECKS}, Failed checks: ${FAILED_CHECKS}, Skipped checks: ${SKIPPED_CHECKS}"

# Display detailed information for failed checks
if [ "${FAILED_CHECKS}" -gt 0 ]; then
  jq -r '.results.failed_checks[] | "Check: \(.check_name) - \(.check_id)\n        \(.message)\n        \(.file):\n\n\(.code_block)"' checkov_output.json
fi

# Optional: Fail the CI/CD pipeline if there are failed checks
if [ "${FAILED_CHECKS}" -gt 0 ]; then
  echo "Checkov found issues in your Terraform code. Please review the output."
  exit 1
else
  echo "Checkov scan passed. No issues found."
fi
