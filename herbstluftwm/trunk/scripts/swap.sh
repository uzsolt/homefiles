#!/bin/sh

STATUS=""

update_status() {
    STATUS=`swapinfo | sed -rn "$ s@.* ([^ ]*)%@\1@p"`
}

update_status

echo ${STATUS}
(sleep 3 ; herbstclient emit_hook user_swap ${STATUS}) &

while true; do
    OLD_STATUS=${STATUS}
    update_status
    if [ ${STATUS} -ne ${OLD_STATUS} ]; then
        herbstclient emit_hook user_swap ${STATUS}
    fi
    sleep 5
done

