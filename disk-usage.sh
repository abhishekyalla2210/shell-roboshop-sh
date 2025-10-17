#!/bin/bash

DISK_USAGE=$(df -hT | grep -v Filesystem)
DISK_THRESHOLD=2  
MESSAGE=""
IP_ADDRESS= $(curl -s http://169.254.169.254/latest/meta-data/local-ipv4)

while IFS= read -r line
do

 USAGE=$(echo $line| awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7}')
    if [ $USAGE -ge $DISK_THRESHOLD ]; then
    MESSAGE+="high disk usage in $PARTITION: $USAGE% \n"
        
    fi
done <<< $DISK_USAGE
echo -e "message body: $MESSAGE"

sh mail.sh "abhishekyalla7@gmail.com" "high disk usage alert" "high disk usage" "$MESSAGE" "$IP_ADDRESS" "DEVOPS team"
