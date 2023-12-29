#!/bin/bash

BUCKET_NAME="owzapsst"
DC_VERSION="6.4.2"  # Replace with the latest available version

# Download and run OWASP Dependency-Check
wget "https://dl.bintray.com/jeremy-long/owasp/dependency-check-${DC_VERSION}-release.zip" -O dependency-check.zip

if [ $? -ne 0 ]; then
  echo "Error downloading Dependency-Check ZIP."
  exit 1
fi

unzip dependency-check.zip

if [ $? -ne 0 ]; then
  echo "Error unzipping Dependency-Check."
  exit 1
fi

cd dependency-check-${DC_VERSION}-release

# Run Dependency-Check scan
./bin/dependency-check.sh --scan .

if [ $? -ne 0 ]; then
  echo "Error running Dependency-Check scan."
  exit 1
fi

# Sync Dependency-Check reports to S3 bucket
aws s3 sync .dependency-check/ s3://${BUCKET_NAME}/dependency-check

if [ $? -ne 0 ]; then
  echo "Error syncing Dependency-Check reports to S3."
  exit 1
fi