#!/usr/local/bin/bash

pgrep -q herbstluftwm || exit 0

export DISPLAY=:0

LOGFILE=$HOME/logfiles/hlwm-battery

source ${LOGFILE}

STATUS=($(sysctl hw.acpi.battery.{life,state} | sed "s@.*: @@"))

new_life=${STATUS[0]}
new_state=${STATUS[1]}

if [ $state -ne $new_state -o $life -ne $new_life ]; then
    /usr/local/bin/herbstclient emit_hook user_battery ${new_state} ${new_life}
    echo "state=${new_state}" > $LOGFILE
    echo "life=${new_life}" >> $LOGFILE
fi

