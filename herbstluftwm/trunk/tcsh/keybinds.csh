#!/bin/tcsh

source ${0:h}/conf-keymain.csh
source ${0:h}/conf-keybinds.csh

herbstclient keyunbind --all

set keys=""
foreach keyb ($keybinds:q)
    set keys="${keys} SEP keybind ${keyb}"
end
herbstclient chain ${keys}

