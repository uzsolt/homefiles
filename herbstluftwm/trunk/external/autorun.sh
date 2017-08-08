#!/bin/sh

wmname LG3D
rm -f /home/zsolt/passwords.kdb.lock && keepassx -min &
conky -d -c /home/zsolt/.config/herbstluftwm/external/conkyrc
(sleep 1 ; stalonetray -c /home/zsolt/.config/herbstluftwm/external/stalonetray) &

