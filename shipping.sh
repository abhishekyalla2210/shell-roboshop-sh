#!/bin/bash

source ./common.sh
APP_NAME=shipping

CHECK_ROOT
VALIDATE
APP_SETUP
JAVA_SETUP 
SYSTEM_SETUP

 dnf install mysql -y &>>$LOG_FILE

 VALIDATE $? "installed mysql"

 mysql -h $MYSQL_ID -uroot -pRoboShop@1 -e 'use cities' &>>$LOG_FILE

 if [ $? -ne 0 ]; then
 mysql -h $MYSQL_ID -uroot -pRoboShop@1 < /app/db/schema.sql 
 mysql -h $MYSQL_ID -uroot -pRoboShop@1 < /app/db/app-user.sql  
 mysql -h $MYSQL_ID -uroot -pRoboShop@1 < /app/db/master-data.sql 
 else
     echo "shipping data already exist ...$Y skipping $N"
 fi
 APP_RESTART
 PRINT_TOTAL_TIME