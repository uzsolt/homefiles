#!/bin/sh

HLWM_DIR="${XDG_CONFIG_HOME}/herbstluftwm"
/usr/sbin/daemon -p ~/logfiles/hlwm-dzen2.pid ${HLWM_DIR}/scripts/hlwm-dzen2-display.sh
/usr/sbin/daemon -r -p ~/logfiles/hlwm-mpd.pid ${HLWM_DIR}/scripts/mpd-idle.sh
/usr/sbin/daemon -r -p ~/logfiles/hlwm-battery.pid ${HLWM_DIR}/scripts/battery.sh
/usr/sbin/daemon -r -p ~/logfiles/hlwm-swap.pid ${HLWM_DIR}/scripts/swap.sh
/usr/sbin/daemon -r -p ~/logfiles/hlwm-task.pid ${HLWM_DIR}/scripts/taskwarrior.sh
/usr/sbin/daemon -r -p ~/logfiles/hlwm-gmail_hook.pid ${HLWM_DIR}/scripts/check_gmail
/usr/sbin/daemon -r -p ~/logfiles/hlwm-newsbeuter_hook.pid ${HLWM_DIR}/scripts/check_newsbeuter

