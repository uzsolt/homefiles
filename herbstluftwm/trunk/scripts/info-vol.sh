#!/bin/sh

. /home/zsolt/.config/herbstluftwm/scripts/info-func.sh

{
    echo "Volume"
    {
        mixer vol
        mixer pcm
    } | sed "s@Mixer \([^ ]*\)[^0-9]*\([0-9]*\):.*@\1 \2@"
} | display_info
