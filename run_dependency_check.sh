#!/bin/bash

BUCKET_NAME="owzapsst"
DC_VERSION="9.0.7"

# Download and run OWASP Dependency-Check from GitHub releases
wget "https://github.com/jeremylong/DependencyCheck/releases/download/v${DC_VERSION}/dependency-check-${DC_VERSION}-release.zip" -O dependency-check.zip

if [ $? -ne 0 ]; then
  echo "Error downloading Dependency-Check ZIP."
  exit 1
fi

unzip dependency-check.zip

if [ $? -ne 0 ]; then
  echo "Error unzipping Dependency-Check."
  exit 1
fi

# Find the Dependency-Check directory
DC_DIRECTORY=$(find . -maxdepth 1 -type d -name 'dependency-check*')

if [ -z "$DC_DIRECTORY" ]; then
  echo "Error finding Dependency-Check directory."
  exit 1
fi

cd "$DC_DIRECTORY"

# Run Dependency-Check scan and capture log
./bin/dependency-check.sh --scan . 2>&1 | tee dependency-check-scan.log

if [ $? -ne 0 ]; then
  echo "Error running Dependency-Check scan."
  cat dependency-check-scan.log  # Print detailed logs
  exit 1
fi

# Sync Dependency-Check reports to S3 bucket
if [ -d .dependency-check ]; then
  aws s3 sync .dependency-check/ s3://${BUCKET_NAME}/dependency-check
  if [ $? -ne 0 ]; then
    echo "Error syncing Dependency-Check reports to S3."
    exit 1
  fi
else
  echo "The directory .dependency-check/ does not exist. Skipping S3 sync."
fi
