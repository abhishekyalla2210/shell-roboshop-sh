#!/bin/bash
USERID=$(id -u)
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
SOURCE_DIR=$1
DEST_DIR=$2




LOGS_FOLDER="/var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/backup.log" # /var/log/shell-script/16-logs.log

mkdir -p $LOGS_FOLDER
echo "Script started executed at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
    echo "ERROR:: Please run this script with root privelege"
    exit 1 # failure is other than 0
fi
USAGE(){
    echo -e "$R USAGE:: sudo sh delete.sh <SOURCE_DIR> <DEST_DIR> <DAYS>[optional, default 14 days] $N"
    exit 1
}
if [ $# -lt 2 ]; then
    USAGE
fi


SOURCE_DIR=/home/ec2-user/source_dir
DEST_DIR=/home/ec2-user/dest_file

if [ ! -d $SOURCE_DIR ]; then
    echo -e "ERROR:: $SOURCE_DIR does not exist"
    exit 1
fi

if [ ! -d $DEST_DIR ]; then
    echo -e "ERROR:: $DEST_DIR does not exist"
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -type f )

if [ ! -z "{$FILES}" ]; then
echo "files found:$FILES"
TIMESTAMP=$(date +%F-%H-%M)
ZIP_FILE_NAME="$DEST_DIR/app-logs-$TIMESTAMP.zip"
echo "zip file name:$ZIP_FILE_NAME"
find $FILES  | zip -@ -j "$ZIP_FILE_NAME"
else 
    echo "files missing"
fi

if [ -f $ZIP_FILE_NAME ];then
    echo "Archival success"

    while IFS= read -r filepath
        do
            echo "Deleting the file: $filepath"
            rm -rf $filepath
            echo "Deleted the file: $filepath"
        done <<< $FILES

else
    echo "archeiving failure"
exit 1
fi


