#!/bin/bash
#modified from original script on https://forum.lisk.io/viewtopic.php?t=395 by sgdias

#Adapted for screen sessions

SHIFT_SCREEN="new"
echo "Antifork started.."

tail -Fn0 ~/shift/logs/shift.log |
while read line ; do

    echo "$line" | grep "Fork"
    if [ $? = 0 ]; then
        echo "Fork found: $line"
    fi

       echo "$line" | grep "\"cause\":2"
    if [ $? = 0 ]; then
        echo "Fork with root cause code 2 found. Restarting node main."
        echo "Auto restarting node..."
	#stop node app.js
	screen -S $SHIFT_SCREEN -p 0 -X stuff "^C"
	screen -S $SHIFT_SCREEN -p 0 -X stuff "node app.js$(printf \\r)"

        echo "Auto Restarting Done"

    fi


done
