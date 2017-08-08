#!/bin/sh

PATH=${PATH}:/usr/local/bin
pgrep -q herbstluftwm || exit 0
export DISPLAY=:0

OLD_STATUS=""
while true; do
    STATUS=`swapinfo | sed -rn "$ s@.* ([^ ]*)%@\1@p"`
    if [ "${STATUS}" != "${OLD_STATUS}" ]; then
        herbstclient emit_hook user_swap ${STATUS}
        OLD_STATUS=${STATUS}
    fi
    sleep 10
done


