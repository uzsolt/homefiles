display_info() {
    tmpfile=`mktemp`
    {
        read LINE
        TITLE="=== ${LINE} ==="
        max=`echo ${TITLE} | wc -m`
        while read LINE; do
            echo ${LINE}
        done
        length=`echo ${LINE} | wc -m`
        [ ${max} -lt ${length} ] && max=${length}
    } > ${tmpfile}
    width=`echo "${max}*12" | bc`
    {
        echo ${TITLE}
        cat ${tmpfile} 
    } | dzen2 -w ${width} -l `wc -l < ${tmpfile}` -e "onstart=uncollapse" -p 5
    rm ${tmpfile}
}

