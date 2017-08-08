#!/bin/sh

mpc idleloop player | while read line; do
    ~/.config/herbstluftwm/scripts/info-mpd.sh
done

