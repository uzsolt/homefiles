#!/bin/sh

. `dirname $0`/dzen2-sets.sh

PING_HOST=8.8.8.8

ret=`yad --title="Fordítás" --form --item-separator=, --field="Irány":CB "en:hu","hu:en" --field="Szöveg"`
if [ $? -eq 0 ]; then
    # direction
    d=`echo ${ret} | sed 's,|.*,,'`
    # text
    t=`echo ${ret} | sed 's,.*|\(.*\)|,\1,'`
    {
        echo "net kapcsolat ellenőrzése..."
        ping -t 3 -c 2 ${PING_HOST} > /dev/null
        if [ $? -eq 0 ]; then
            echo "fordítás folyamatban..."
            forditas=`trans -b ${d} ${t}`
            echo "${t}: ${forditas}"
        else
            echo "[[ nincs net ]]"
        fi
        sleep 5
    } | dzen2 ${DZEN2_INFO} &
fi

