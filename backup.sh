#!/bin/bash

count=5
 

echo -e " starting countdown:"

while [ $count -ge 0 ]
do
    echo "count=$count"
    sleep 1

    count=$((count - 1))
    done 
    echo "times up!"