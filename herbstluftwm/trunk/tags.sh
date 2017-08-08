#!/bin/sh

. ~/.config/herbstluftwm/include.sh

#TAG_NAMES=( term web rss dox torrent dev bsd lowr loimp music )

HL_LAYOUT_term='(clients max:0)'
HL_LAYOUT_web='(clients max:0)'
HL_LAYOUT_rss='(clients max:0)'
HL_LAYOUT_dox='( split horizontal:0.5:1 (clients max:0) (clients max:1) )'
HL_LAYOUT_torrent='(clients max:0)'
HL_LAYOUT_dev='(clients max:0)'
HL_LAYOUT_bsd='(clients max:0)'
HL_LAYOUT_lowr='(clients max:0)'
HL_LAYOUT_loimp='(clients max:0)'
HL_LAYOUT_music='(clients max:0)'
HL_LAYOUT_burn='(clients max:0)'
HL_LAYOUT_util='(clients max:0)'
HL_LAYOUT_game='(clients max:0)'
HL_LAYOUT_vps='(clients max:0)'

hc pad 0 20 0 0
hc rename default "term" || true
LAYOUTS=`set | sed -n "/^HL_LAYOUT_/ s@HL_LAYOUT_\([^_=]*\).*@\1@p"`

for i in ${LAYOUTS} ; do
    hc add "${i}"
    eval hc load "${i}" \"\$HL_LAYOUT_${i}\"
done

