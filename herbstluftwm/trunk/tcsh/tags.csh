#!/bin/tcsh

source ${0:h}/conf-tags.csh
herbstclient rename default "term" || true

foreach t (${tags:q})
    herbstclient add "${t:h:e}"
    herbstclient load "${t:h:e}" "${t:t}"
end

