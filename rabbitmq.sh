#!/bin/bash

source ./common.sh
APP_NAME=rabbitmq

CHECK_ROOT



cp $SCRIP_NAME rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
VALIDATE $? "copied rabbitmq repo"

dnf install rabbitmq-server -y &>>$LOG_FILE
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