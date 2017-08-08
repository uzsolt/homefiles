#!/bin/tcsh

source ${XDG_CONFIG_HOME}/herbstluftwm/conf-keymain.csh
source ${XDG_CONFIG_HOME}/herbstluftwm/conf-keychains.csh
source ${XDG_CONFIG_HOME}/herbstluftwm/conf-tags.csh

set kc_changetag=()
set kc_movetag=()

set sep=" +++ "
set hksep=" @@@ "

foreach t (${tags:q})
    set kc_changetag=(${kc_changetag:q} "'${t:h:r}/use ${t:h:e}'")
    set kc_movetag=(${kc_movetag:q} "'${t:h:r}/move ${t:h:e}'")
end

set ALL=""
foreach kc ($keychains:q)

    set kcn=${kc:t:e}
    set kc_hk=${kc:h}
    set kc_info=${kc:t:r:q}

    eval set `set | sed -n "/^${kcn}/ s@^${kcn}@kctmp=@p"`

    set unbind="${sep} emit_hook chain_leave ${sep} keyunbind Escape"
    set bindarr=()
    foreach kct (${kctmp:q})
        set hk=${kct:ah}
        set ln=${%hk}
        @ ln += 2
        set cmd=`echo ${kct} | cut -b ${ln}-`
        set unbind="${unbind} ${sep} keyunbind ${hk}"
        set bindarr=(${bindarr:q} "keybind ${hk} chain ${sep} ${cmd}")
    end

    set bind=""
    foreach b (${bindarr:q})
        set bind="${bind} ${hksep} ${b} ${unbind}"
    end

    herbstclient keybind ${kc_hk} chain ${hksep} \
        emit_hook chain_enter ${kc_info} \
        ${bind} \
        ${hksep} keybind Escape chain ${unbind}

end

