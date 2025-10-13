#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

LOGS_FOLDER="var/logs/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir $LOGS_FOLDER
echo "script started at:$(date)"

SOURCE_DIR=/home/ec2-user/app-logs

if [  ! -d $SOURCE_DIR ]; then
    echo -e "error $SOURCE_DIR does not exist"
    exit 1
fi

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -type f)

while IFS= read -r filepath
do
    echo "deleting  files: $filepath"
done <<< $FILES_TO_DELETE