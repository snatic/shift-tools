#!/bin/bash

#modified from original script on https://forum.lisk.io/viewtopic.php?t=395 by sgdias

#forever installed needed

tail -Fn0 ./logs/shift.log |
while read line ; do

    echo "$line" | grep "Fork"
    if [ $? = 0 ]; then
        echo "Fork found: $line"
    fi

    
       echo "$line" | grep "\"cause\":2"
    if [ $? = 0 ]; then
        echo "Fork with root cause code 2 found. Restarting node main."
        echo "Auto restarting node..."
        killall -15 node
        killall -15 nodejs
        sleep 5
        forever start app.js
        echo "Auto Restarting Done"

    fi


done