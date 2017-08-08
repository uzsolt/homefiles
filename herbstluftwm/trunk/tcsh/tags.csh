#!/bin/tcsh

source ${XDG_CONFIG_HOME}/herbstluftwm/conf-tags.csh

foreach t (${tags:q})
    herbstclient chain SEP add "${t:h:e}" SEP load "${t:h:e}" "${t:t}"
end

