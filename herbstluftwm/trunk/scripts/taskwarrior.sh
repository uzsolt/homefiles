#!/bin/sh

get_due_task() {
    PARAM="due.before:${2}day"
    [ ${1} -gt 0 ] && PARAM="${PARAM} due.after:${1}day"
    DT=`task ${PARAM} 2>/dev/null | tail -1 | sed "s@ task.*@@"`
    if [ -z "${DT}" ]; then
        DT=0
    fi
    echo ${DT}
}

URGENT=`get_due_task 0 5`
LOW_URGENT=`get_due_task 5 10`

herbstclient emit_hook user_taskwarrior ${URGENT} ${LOW_URGENT}
