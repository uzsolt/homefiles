#!/bin/sh
. `dirname $0`/dzen2-sets.sh

ret=`yad --title="Számolás" --form --item-separator=, --field="Számítás" | sed 's@|$@@'`

( echo -n "${ret}= " ; echo ${ret} | bc -l ; sleep 5) | dzen2 ${DZEN2_INFO} &

