#!/bin/bash

source ./common.sh
APP_NAME=rabbitmq

CHECK_ROOT
VALIDATE

cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "copied rabbitmq repo"
dnf install rabbitmq-server -y &>>$LOGFILE
VALIDATE $? "installed"
systemctl enable rabbitmq-server
VALIDATE $? "enabled"
systemctl start rabbitmq-server
VALIDATE $? "started"
rabbitmqctl add_user roboshop roboshop123
VALIDATE $? "user added"
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
VALIDATE $? "permissions set"

APP_NAME
PRINT_TOTAL_TIME