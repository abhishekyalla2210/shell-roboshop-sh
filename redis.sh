#/bin/bash

source ./common.sh

CHECK_ROOT
VALIDATE

dnf module disable redis -y
VALIDATE $? "redis disable"
dnf module enable redis:7 -y
VALIDATE $? "enable redis"
dnf install redis -y &>>$LOG_FILE
VALIDATE $? "installing redis"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/redis/redis.conf
VALIDATE $? "changed remote"

sed -i '/protected-mode/c protected-mode no' /etc/redis/redis.conf
VALIDATE $? "protect mode"

systemctl daemon-reload 
systemctl enable redis 
VALIDATE $? "enabled"
systemctl start redis 
VALIDATE $? "started"
APP_RESTART
PRINT_TOTAL_TIME