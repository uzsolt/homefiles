#!/bin/sh

NR_PARAMS=3
CSV_PARENT=lista_szulo.csv
CSV_STUDENT=lista_diak.csv
CSV_TEACHER=lista_tanar.csv
CODE_PARENT=kod_szulo.csv
CODE_STUDENT=kod_diak.csv
CODE_TEACHER=kod_tanar.csv

error() {
  echo "HIBA: " $*
}

usage() {
  printf 'Használat: send-emails.sh "TanárNeve" "Határidő" "alkönyvtár"\n'
  printf "Fájlok:\n\t%s\t%s\n\t%s\t%s\n\t%s\t%s\n\t%s\t%s\n\t%s\t%s\n\t%s\t%s\n" \
    ${CSV_PARENT} "Szülők email-címei" \
    ${CSV_STUDENT} "Diákok email-címei" \
    ${CSV_TEACHER} "Tanárok email-címei" \
    ${CODE_PARENT} "Szülők kódjai" \
    ${CODE_STUDENT} "Diákok kódjai" \
    ${CODE_TEACHER} "Tanárok kódjai"
}

test_files() {
  local RET=0
  echo "Fájlok ellenőrzése"
  for f in ${CSV_PARENT} ${CODE_PARENT} ${CSV_STUDENT} ${CODE_STUDENT} ${CSV_TEACHER} ${CODE_TEACHER}; do
    printf "\t%s ... " ${f}
    if [ -r ${SUBDIR}/${f} ]; then
      printf "van, %s sor\n" `grep -v '^$' ${SUBDIR}/${f} | wc -l`
    else
      echo "NINCS"
      RET=$((RET+1))
    fi
  done

  if [ ${RET} -gt 0 ]; then
    error "${RET} fájl hiányzik!"
  else
    printf "Fájlok rendben.\nKérem, ellenőrizze a kitöltők és a kódok számának egyezőségét!\n"
  fi

  return ${RET}
}

# 1. LINK
# 2. TANÁR
# 3. HATÁRIDŐ
# 4. Egyéb közlendő
generate_message() {
  cat << EOF
Tisztelt Címzett!

Az Orszagos pedagógiai-szakmai ellenőrzéshez kapcsolódó pedagógusi önértékelés keretében
Önnek lehetősége van visszajelzést adni a pedagógus munkájával kapcsolatban.

Kérjük, hogy az alábbi linkre kattintva a felületen értékelje 0-5-ig a
pedagógus pedagógiai tevékenységét a megadott szempontok alapján.
Az állításokkal való egyetértés mértékét a megadott skálán jelölje!

A kitöltés mindössze 2-3 percet vesz igénybe, kérjük, segítse ezzel a munkánkat!

EOF
printf "Link: %s\nA kérdőívezésben értékelt pedagógus: %s\nA kérdőív kitöltésének határideje: %s\n%s\n" "${1}" "${2}" "${3}" "${4}"
  cat << EOF
Bármely probléma esetén kérem, erre a levélre válaszoljon!

Segítségét és véleményét köszönjük!

Tisztelettel:
  Udvari Zsolt
  Bethlen Gábor Református Gimnázium
EOF
}

# 1. EMAIL-LISTA
# 2. KÓD-LISTA
combine_link_email() {
  cat ${SUBDIR}/${2} | awk -F '|' '{print "http://"$4}' | paste -d '|' - ${SUBDIR}/${1}
}

# 1. EMAIL-LISTA
# 2. KÓD-LISTA
# 3. Egyéb üzenet
send_emails() {
  OLDIFS=${IFS}
  IFS="|"
  test_message "${1}" "${2}" || exit 1
  combine_link_email "${1}" "${2}" | while read url email1 email2 ; do
    printf "E-mail küldése: %s\n" "${email1} ${email2}"
    generate_message "${url}" "${TEACHER_NAME}" "${DEADLINE}" "${3}" | mutt -s '[Bethlen] Pedagogus onertekeles kerdoiv' "${email1}" "${email2}"
    sleep 3
    printf "Küldve.\n"
  done
}

# 1. EMAIL-LISTA
# 2. KÓD-LISTA
test_message() {
  printf "Kérem, ellenőrizze, megfelelő-e az üzenet formája!\n\n<<<< Üzenet kezdődik >>>>\n\n"
  combine_link_email "${1}" "${2}" | head -n 1 | while read url email; do
    generate_message "${url}" "${TEACHER_NAME}" "${DEADLINE}"
  done
  printf "\n<<<< Üzenet vége >>>>\n\nMegfelelő az üzenet és egyeznek a számok (i/n)?\n"
  read answer
  [ "${answer}" = "i" ] && return 0
  return 1
}

if [ $# -ne ${NR_PARAMS} ]; then
  echo Kapott paraméterek száma: $#/${NR_PARAMS}
  usage
  exit 1
fi

TEACHER_NAME=$1
DEADLINE=$2
SUBDIR=$3
printf "Alapadatok\n\tTanár neve: %s\n\tHatáridő: %s\n\tAlkönyvtár: %s\n" "${TEACHER_NAME}" "${DEADLINE}" "${SUBDIR}"
test_files || exit 1

printf "\nKüldjük a tanároknak (i/n)?\n"
read answer
[ "${answer}" = "i" ] && send_emails ${CSV_TEACHER} ${CODE_TEACHER}

printf "\nKüldjük a szülőknek (i/n)?\n"
read answer
[ "${answer}" = "i" ] && send_emails ${CSV_PARENT} ${CODE_PARENT} "Egy család csak egy szülői kérdőívet tölt ki."

printf "\nKüldjük a diákoknak (i/n)?\n"
read answer
[ "${answer}" = "i" ] && send_emails ${CSV_STUDENT} ${CODE_STUDENT}

