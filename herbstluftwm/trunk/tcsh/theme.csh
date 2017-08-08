#!/bin/tcsh

source ${XDG_CONFIG_HOME}/herbstluftwm/conf-theme.csh

set chains=""
foreach th ($theme:q)
    set chains="${chains} SEP set ${th}"
end
herbstclient chain ${chains}

