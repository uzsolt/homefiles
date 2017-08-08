#!/bin/tcsh

source ${0:h}/conf-tags.csh
herbstclient rename default "term" || true

foreach t (${tags:q})
    herbstclient chain SEP add "${t:h:e}" SEP load "${t:h:e}" "${t:t}"
end

