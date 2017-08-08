#!/bin/tcsh

source ${XDG_CONFIG_HOME}/herbstluftwm/conf-rules.csh

herbstclient unrule -F
set chains=""
foreach rule ($rules:q)
    set chains="${chains} SEP rule ${rule}"
end

herbstclient chain ${chains}

