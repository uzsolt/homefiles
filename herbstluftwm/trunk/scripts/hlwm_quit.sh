#!/bin/sh

LINES=`wmctrl -l | grep -v "tmux\|RSS" | wc -l`
pgrep -q vim && LINES=$(( LINES+1 ))

if [ ${LINES} -gt 0 ]; then
    (
        echo "Herbstluftwm kilépés - futó programok"
        wmctrl -l | grep -v "tmux\|RSS" | sed "s@.*bsd-zsolt @@"
        pgrep -q vim && echo VIM
        sleep 5
    ) | dzen2 -x 800 -y 40 -w 566 -l ${LINES} -e "onstart=uncollapse" -bg "red" -fg "white"

fi
