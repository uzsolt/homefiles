#!/bin/sh

. /home/zsolt/.config/herbstluftwm/scripts/info-func.sh

PATH=${PATH}:/usr/local/bin

( echo Torrent
  transmission-remote -si | sed -n "/load speed limit/ s@^ *\([^(]*\).*@\1@p"
  echo
  transmission-remote -st | sed -n "2,$ p"
) | display_info
