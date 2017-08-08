#!/bin/sh

# a i3-like scratchpad for arbitrary applications.
#
# this lets a new monitor called "scratchpad" appear in from the top into the
# current monitor. There the "scratchpad" will be shown (it will be created if
# it doesn't exist yet). If the monitor already exists it is scrolled out of
# the screen and removed again.
#
# Warning: this uses much resources because herbstclient is forked for each
# animation step.
#
# If a tag name is supplied, this is used instead of the scratchpad

tag="${1:-scratchpad}"
rect=`herbstclient monitor_rect "" | awk '{printf "%d %d %d %d",$3/2,$4/2,$1+$3/4,$2+$4/4}'`

#rect=(
#    $((width/2))
#    $((height/2))
#    $((${mrect[0]}+(width/4)))
#    $((${mrect[1]}+(height/4)))
#)

herbstclient add "$tag"

monitor=scratchpad

exists=false
if ! herbstclient add_monitor $(printf "%dx%d+%d+%d" ${rect}) \
                    "$tag" $monitor 2> /dev/null ; then
    exists=true
else
    # remember which monitor was focused previously
    herbstclient chain \
        , new_attr string monitors.by-name."$monitor".my_prev_focus \
        , substitute M monitors.focus.index \
            set_attr monitors.by-name."$monitor".my_prev_focus M
fi

show() {
    herbstclient lock
    herbstclient raise_monitor "$monitor"
    herbstclient focus_monitor "$monitor"
    herbstclient unlock
    herbstclient lock_tag "$monitor"
}

hide() {
    # if q3terminal still is focused, then focus the previously focused monitor
    # (that mon which was focused when starting q3terminal)
    herbstclient substitute M monitors.by-name."$monitor".my_prev_focus \
        and + compare monitors.focus.name = "$monitor" \
            + focus_monitor M
    herbstclient remove_monitor "$monitor"
}

[ $exists = true ] && hide || show

