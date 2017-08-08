#!/usr/local/bin/bash

export DISPLAY=:0
LOGFILE=$HOME/logfiles/hlwm-swap

source ${LOGFILE}
STATUS=`swapinfo | sed -rn "$ s@.* ([^ ]*)%@\1@p"`

if [ ${STATUS} -ne ${OLD_STATUS} ]; then
    herbstclient emit_hook user_swap ${STATUS}
    echo "OLD_STATUS=${STATUS}" > ${LOGFILE}
fi

