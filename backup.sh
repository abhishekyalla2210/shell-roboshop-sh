#!/bin/bash

R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
USER_ID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2

LOGS_FOLDER="var/log/shell-script"
SCRIPT_NAME=$( echo $0 | cut -d "." -f1 )
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"

mkdir $LOGS_FOLDER
echo "script started at:$(date)"

SOURCE_DIR=/home/ec2-user/app-logs
  
  if [ $USER_ID -ne 0 ]; then
    echo -e $R "please login with root access $N"
    exit 1
fi

USAGE(){
echo "USAGE: sudo sh backup"
}

if [ $# -lt 2 ]; then
  USAGE
fi
  
  if [ ! -d $SOURCE_DIR ]; then
    echo "source does not exist"
    exit 1
  fi


if [ ! -d $DEST_DIR ]; then
    echo "dest does not exist"
    exit 1
  fi

