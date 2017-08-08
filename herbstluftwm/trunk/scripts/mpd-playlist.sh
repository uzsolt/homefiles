#!/bin/sh

song=`mpc playlist | dmenu -i -l 30 -b -nb "#000" -nf "#7af" -sb "#000" -sf "#bdf" -p "Find:" | cut -d')' -f1`
song="`mpc playlist | awk '{if($0 == "'"${song}"'") {print NR}}'`"

[ -n "${song}" ] && mpc play "${song}"

