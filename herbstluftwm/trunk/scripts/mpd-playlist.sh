#!/bin/sh

CURRENT=$(mpc -f "%position%. [[%artist% - ]%title%]|[%file%]" | grep "^[0-9]")
TOPLAY=$(mpc -f "%position%. [[%artist% - ]%title%]|[%file%]" playlist | dmenu -l 30 -i -p "${CURRENT}")

if [ $? -eq 0 ]; then
    mpc play $(echo ${TOPLAY} | sed "s@^\([0-9]*\).*@\1@")
fi

