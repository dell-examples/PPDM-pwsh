#!/bin/bash

#
# Copyright (c) 2024 Dell Inc. or its subsidiaries. All Rights Reserved.
#
# This software contains the intellectual property of Dell Inc.
# or is licensed to Dell Inc. from third parties. Use of this
# software and the intellectual property contained therein is
# expressly limited to the terms and conditions of the License
# Agreement under which it is provided by or on behalf of Dell
# Inc. or its subsidiaries.
#

# $PG_BASEBACKUP_PATH is the path of the pg_basebackup utility


# DD_TARGET_DIRECTORY is an exported value of the Destination path by the agent
BASE_BACKUP_DIR=${DD_TARGET_DIRECTORY}

# Process command line options
while getopts ":m:p:" opt; do
  case $opt in
    # $PORT_NAME is the name of the database port to connect
    m)
      MOUNT_POINT="$OPTARG"
      ;;
    # $WAL_PATH is the path to the write ahead log (WAL) directory
    p)
      PREFIX="$OPTARG"
      ;;
    # Invalid option
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
  esac
done

echo "entering Backup phase"
if [ -z $BASE_BACKUP_DIR ]; then
    echo "Not provided the backup directory for BASE_BACKUP_DIR"
    exit 1
fi
if [ -z $BACKUP_LEVEL ]; then
    echo "Not provided the backup level for BACKUP_LEVEL"
    exit 1
fi


# Perform a full backup
if [[ "$BACKUP_LEVEL" == "FULL" ]]; then
            COPY_COMMAND=" rsync -r --no-compress"
            if ! which rsync &> /dev/null; then
                echo "rsync not found. Using scp"
                COPY_COMMAND="scp -r"
            fi
            ${COPY_COMMAND} "${MOUNT_POINT}${PREFIX}" "${BASE_BACKUP_DIR}/"
            exit_status=$?
    if [ $exit_status -ne 0 ]; then
       echo "Unable to perform FULL backup"
       exit 1
    fi
    echo "Backup Completed Successfully"
    exit 0

# Perform a log backup
elif [[ "$BACKUP_LEVEL" == "LOG" ]]; then
            COPY_COMMAND=" rsync -r --no-compress"
            if ! which rsync &> /dev/null; then
                echo "rsync not found. Using scp"
                COPY_COMMAND="scp -r"
            fi
            ${COPY_COMMAND} "${MOUNT_POINT}${PREFIX}" "${BASE_BACKUP_DIR}/"
            exit_status=$?
    if [ $exit_status -ne 0 ]; then
       echo "Unable to perform FULL backup"
       exit 1
    fi
    echo "Backup Completed Successfully"
    exit 0
else
    echo "Invalid backup level. Please specify 'FULL' or 'LOG'."
    exit 1
fi
