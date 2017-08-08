#!/bin/sh
PATH=${PATH}:/usr/local/bin

( echo "=== Window properties ==="
  herbstclient attr clients.focus | sed -n \
    "/^ s/ s@[^-]*- \([^ ]*\).*=@\1 =@p"
  sleep 5
) | dzen2 -w 200 -l 6 -e "onstart=uncollapse"

