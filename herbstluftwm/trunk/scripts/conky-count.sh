#!/bin/sh

NUM=`head -n 1 $1`
logger -t herbstluftwm "$0 $*"
[ ${NUM} -gt 0 ] && echo "$2:${NUM}"
