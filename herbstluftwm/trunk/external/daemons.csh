#!/bin/csh

set daemons = (\
    ".dzen2/hlwm-dzen2-display.sh"\
    "-r.mpd/mpd-idle.sh"\
    "-r.battery/battery.sh"\
    "-r.swap/swap.sh"\
    "-r.task/taskwarrior.sh"\
    "-r.gmail_hook/check_gmail"\
    "-r.newsbeuter_hook/check_newsbeuter"\
)

foreach dmn (${daemons:q})
    echo /usr/sbin/daemon ${dmn:h:r} -p ~/logfiles/hlwm-${dmn:h:e}.pid ${0:h}/../scripts/${dmn:t}
end

