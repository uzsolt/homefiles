#!/usr/local/bin/bash

pgrep -q herbstluftwm || exit 0

export DISPLAY=:0

get_due_task() {
    PARAM="due.before:${2}day"
    [ ${1} -gt 0 ] && PARAM="${PARAM} due.after:${1}day"
    DT=`/usr/local/bin/task ${PARAM} 2>/dev/null | tail -1 | sed "s@ task.*@@"`
    if [ -z "${DT}" ]; then
        DT=0
    fi
    echo ${DT}
}

VERY_URGENT=`get_due_task 0 2`
URGENT=`get_due_task 2 3`
LOW_URGENT=`get_due_task 3 7`

/usr/local/bin/herbstclient emit_hook user_taskwarrior ${VERY_URGENT} ${URGENT} ${LOW_URGENT}
