#!/bin/bash

source ./common.sh
APP_NAME=payment

CHECK_ROOT
APP_SETUP

cp $SCRIPT_DIR/payment.service /etc/systemd/system/payment.service &>>$LOG_FILE
VALIDATE $? "looking"

systemctl daemon-reload
systemctl enable payment

APP_RESTART