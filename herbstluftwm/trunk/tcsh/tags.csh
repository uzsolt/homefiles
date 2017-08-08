#!/bin/tcsh

source ${0:h}/conf-tags.csh

foreach t (${tags:q})
    herbstclient chain SEP add "${t:h:e}" SEP load "${t:h:e}" "${t:t}"
end

