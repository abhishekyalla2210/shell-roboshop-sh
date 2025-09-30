#!/bin/bash 

source ./commom.sh

CHECK_ROOT
VALIDATE

dnf install mysql-server -y &>>$LOG_FILE
VALIDATE $? "installed mysql"
systemctl enable mysqld
VALIDATE $? "enabled"
systemctl start mysqld
VALIDATE $? "started"  
mysql_secure_installation --set-root-pass RoboShop@1
VALIDATE $? "passwordset"

APP_RESTART
PRINT_TOTAL_TIME