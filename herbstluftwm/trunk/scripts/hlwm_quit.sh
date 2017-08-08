#!/bin/sh

PATH=$PATH:/usr/local/bin

FOUND=0
for id in `herbstclient attr clients | sed -r "/.*children|focus|attributes|^$/d ; s@\.@@"`; do
    wmclass=`herbstclient attr clients.${id}.class`
    if echo "${wmclass}" | grep -q "libreoffice"; then
        herbstclient jumpto ${id}
        herbstclient close ${id}
        FOUND=1
    elif echo "${wmclass}" | grep -q "Firefox"; then
        herbstclient close ${id}
        #FOUND=1
    fi
done

VIM=0
for server in `vim --serverlist`; do
    vim --remote-send "<ESC>:wqa<CR>"
    VIM=1
done

[ ${VIM} -gt 0 ] && sleep 0.5

[ ${FOUND} -eq 0 ] && herbstclient quit

