#!/bin/sh


client=`wmctrl -l | cat -n | sed "s@^[^0-9]*\([0-9]*\).*0x[0-9a-z]*.*bsd-zsolt \(.*\)@\1 \2@" | dmenu -l 10`
if [ $? -eq 0 ]; then
    nr=`echo ${client} | grep -o "^[0-9]*"`
    herbstclient jumpto `wmctrl -l | sed -n "${nr} s@^\([^ ]*\).*@\1@p"`
fi

