#!/bin/sh

PATH=${PATH}:/usr/local/bin
pgrep -q herbstluftwm || exit 0

export DISPLAY=:0

OLD_STATUS=""
while true; do
    STATUS=`sysctl hw.acpi.battery.state hw.acpi.battery.life | sed "s@.*: @@"`
    if [ "${OLD_STATUS}" != "${STATUS}" ]; then
        herbstclient emit_hook user_battery ${STATUS}
        OLD_STATUS="${STATUS}"
    fi
    sleep 10
done

