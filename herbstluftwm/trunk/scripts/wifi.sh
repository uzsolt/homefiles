#!/bin/sh

WDEV=wlan0

SSID=$(ifconfig ${WDEV} | sed -n "s@.*ssid \([^ ]*\) channel .*@\1@p")
if [ -n "${SSID}" ]; then
    SSID_STR=$(ifconfig ${WDEV} scan | sed -n "/^${SSID}/ s@${SSID}.*-\([0-9]*\):-\([0-9]*\).*@(\2-\1)*4@p" | bc)
    echo "${SSID} ${SSID_STR}%"
else
    echo "<no network>"
fi
