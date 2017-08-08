#!/bin/tcsh

source ${0:h}/conf-theme.csh

set chains=""
foreach th ($theme:q)
    set chains="${chains} SEP set ${th}"
end
herbstclient chain ${chains}

