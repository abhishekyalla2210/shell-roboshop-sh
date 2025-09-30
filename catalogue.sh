#!/bin/bash

source ./common.sh
APP_NAME=catalogue

CHECK_ROOT
VALIDATE
NODEJS_SETUP
APP_SETUP



cp $SCRIPT_DIR/mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "copied mongorepo"
dnf install mongodb-mongosh -y &>>$LOG_FILE
VALIDATE $? "mongodb-mongsh installed"
mongosh --host $MONGODB_HOST </app/db/master-data.js &>>$LOG_FILE
VALIDATE $? "load catalogue products"
systemctl restart catalogue
VALIDATE $? "restarted catalogue"
mongosh --host $MONGODB_HOST
VALIDATE $? "hosted"
show dbs
VALIDATE $? "showed dbs"
use catalogue
VALIDATE $? "catalogue used"
show collection
VALIDATE $? "collected"
db.products.find()
VALIDATE $? "found"


APP_RESTART
PRINT_TOTAL_TIME