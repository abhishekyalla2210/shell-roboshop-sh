#!/bin/bash

DISK_USAGE=$(df -hT | grep -v filesystem)
DISK_THRESHOLD=6
MESSAGE=""

while IFS= read -r line
do

 USAGE=$(echo $line | awk '{print $6}' | cut -d "%" -f1)
    PARTITION=$(echo $line | awk '{print $7}')

    if [ $USAGE -ge "$DISK_THRESHOLD" ]; then
        echo "high usage $PARTITION: $USAGE"
    fi
done <<< $DISK_USAGE
