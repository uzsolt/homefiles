#!/bin/sh

mpc idleloop player | while read line; do
    ~/.config/herbstluftwm/scripts/mpd-info.sh
done

