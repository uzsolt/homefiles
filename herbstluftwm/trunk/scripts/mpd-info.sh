#!/bin/sh

ST=`mpc | sed -n 2p`

(
    if [ -z "${ST}" ]; then
    echo '[[ STOPPED ]]'
    else
    STR="[[%artist% - ]%title%]|%file%"
    if echo ${ST} | grep -q "^\[paused\]"; then
        STR=" <<>> ${STR}"
    fi
    mpc -f "${STR}" | head -n 1 
    fi
    sleep 2
) | dzen2 -y 20 -x 663 -w 700 -bg '#002277'
