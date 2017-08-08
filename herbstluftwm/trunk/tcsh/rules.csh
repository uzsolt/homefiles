#!/bin/tcsh

source {$0:h}/conf-rules.csh

herbstclient unrule -F
set chains=""
foreach rule ($rules:q)
    set chains="${chains} SEP rule ${rule}"
end

herbstclient chain ${chains}

