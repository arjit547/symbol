#!/bin/bash

BUCKET_NAME="owzapsst"

# Download and run OWASP Dependency-Check
wget https://dl.bintray.com/jeremy-long/owasp/dependency-check-5.2.4-release.zip
unzip dependency-check-*.zip
cd dependency-check-*
./bin/dependency-check.sh --scan .

# Sync Dependency-Check reports to S3 bucket
aws s3 sync .dependency-check/ s3://${BUCKET_NAME}/dependency-check
