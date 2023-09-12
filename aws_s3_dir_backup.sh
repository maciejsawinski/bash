#!/bin/bash

# variables
S3_BUCKET=""
DIR=""
EXCLUDE_LIST=("node_modules" "build" ".cache" ".git")

# create gzip file
FILE_NAME="${DIR}_$(date +%Y%m%d%H%M).tar.gz"
tar --exclude-from=<(printf "%s\n" "${EXCLUDE_LIST[@]}") -czf $FILE_NAME $DIR

# upload to s3; make sure to "aws configure" and to have a correct aws path
./aws/dist/aws s3 cp $FILE_NAME $S3_BUCKET --expires "$(date -I -d '30 days')" --quiet

# delete file
rm $FILE_NAME
