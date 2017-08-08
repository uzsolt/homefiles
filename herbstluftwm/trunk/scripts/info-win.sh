#!/bin/sh

. /home/zsolt/.config/herbstluftwm/scripts/info-func.sh

PATH=${PATH}:/usr/local/bin

( echo Window properties 
  herbstclient attr clients.focus | sed -n \
    "/^ s/ s@[^-]*- \([^ ]*\).*=@\1 =@p"
) | display_info

