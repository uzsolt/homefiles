#!/bin/sh

LOGFILE="/var/run/automounter.amd.log"
AUTOMOUNTER_DIR="/var/run/automounter.mnt/"
LOG_UMOUNT="removing mountpoint directory"
LOG_MOUNT="creating mountpoint directory"

get_label() {
  echo $* | sed "s|.*mountpoint directory.*/\([^/]*\)\'|\1|"
}

tail -n 1 -f ${LOGFILE} | while read LINE; do
  echo ${LINE} | grep -q "${LOG_UMOUNT}" && notify-send -t 3 "Leválasztva: `get_label ${LINE}`"
  echo ${LINE} | grep -q "${LOG_MOUNT}"  && notify-send -t 3 "Csatolva: `get_label ${LINE}`"
done

