#!/usr/bin/env bash

STATUS=""

function update_status() {
    STATUS=($(sysctl hw.acpi.battery.{life,state} | sed "s@.*: @@"))
}

update_status

while true; do
    OLD_STATUS=(${STATUS[@]})
    update_status
    if [ ${STATUS[1]} -ne ${OLD_STATUS[1]} ]; then
        herbstclient emit_hook user_battery_status ${STATUS[1]}
    fi
    if [ ${STATUS[1]} -eq 1 -o ${STATUS[0]} -lt 20 ]; then
        if [ ${STATUS[0]} -ne ${OLD_STATUS[0]} ]; then
            herbstclient emit_hook user_battery_life ${STATUS[0]}
        fi
    fi
    sleep 5
done

