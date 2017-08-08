#!/bin/tcsh

source ${XDG_CONFIG_HOME}/herbstluftwm/conf-keymain.csh
source ${XDG_CONFIG_HOME}/herbstluftwm/conf-keybinds.csh

herbstclient keyunbind --all

set keys=""
foreach keyb ($keybinds:q)
    set keys="${keys} SEP keybind ${keyb}"
end
herbstclient chain ${keys}

