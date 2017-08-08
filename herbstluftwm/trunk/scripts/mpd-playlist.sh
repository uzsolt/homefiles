#!/bin/sh

CURRENT=$(mpc -f "%position%. [[%artist% - ]%title%]|[%file%]" | grep "^[0-9]")
TOPLAY=$(mpc playlist | nl | sed "s@^ *\([0-9]*\)[[:space:]]*@\1 @" | dmenu -l 30 -i -p "${CURRENT}")

if [ $? -eq 0 ]; then
    #echo ${TOPLAY}
    mpc play $(echo ${TOPLAY} | sed "s@\([0-9]*\).*@\1@")
fi

