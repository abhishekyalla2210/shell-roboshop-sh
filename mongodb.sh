#!/bin/bash

source ./common.sh


CHECK_ROOT
VALIDATE

cp mongo.repo /etc/yum.repos.d/mongo.repo
VALIDATE $? "adding the repo"

dnf install mongodb-org -y &>>$LOGFILE
VALIDATE $? "mongodb installation"

systemctl enable mongod
VALIDATE $? "enabled mongodb"

systemctl start mongod
VALIDATE $? "started mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf
VALIDATE $? "allowing all"

APP_RESTART
PRINT_TOTAL_TIME