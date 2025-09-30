#!/bin/bash

source ./common.sh
APP_NAME=catalogue

CHECK_ROOT
APP_SETUP
NODEJS_SETUP
SYSTEM_SETUP


cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "copied mongorepo"

dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "mongodb-mongsh installed"

mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
VALIDATE $? "load catalogue products"
systemctl restart catalogue
VALIDATE $? "restarted catalogue"


APP_RESTART
PRINT_TOTAL_TIME