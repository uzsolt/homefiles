#!/bin/sh

_TAG=""
_FOCUS=""
_FRAME=""
_TASK1=0
_TASK2=0

_P_TAG=0
_P_FOCUS=120
_P_FRAME=70
_P_DATE=1100
_P_TASK1=1250
_P_TASK2=1280

_TITLE_SED='s@ - Mozilla Firefox@@'

# $1 - winid
# $2 - title
# set the _FOCUS to $2, translate with _TITLE_SED
update_focus() {
  # we don't use winid ($1)
  shift
  _FOCUS=`echo "$*" | sed "${_TITLE_SED}"`
}

update_frame() {
  COUNT=`herbstclient attr tags.focus.curframe_wcount || echo 0`
  F_INDEX=`herbstclient attr tags.focus.curframe_windex`
  F_INDEX=$((F_INDEX+1))
  [ "${COUNT}" -eq 0 ] && F_INDEX=0
  _FRAME="${F_INDEX}/${COUNT}"
}

# $1 - tag
# $2 - monitor
update_tag() {
  _TAG="$1"
}

# $1 - 
# $2 -
update_tasks() {
  _TASK1=$1
  _TASK2=$2
}

msg_date() {
  printf '^pa(%d)^fg(white)%s^fg()' \
    ${_P_DATE} \
    "`date +'%H:%M (%b. %d., %a)'`"
}

msg_focus() {
  printf "^pa(%d)^bg(gray)^fg(black) %s ^bg()^fg()" \
    ${_P_FOCUS} \
    "${_FOCUS}"
}

msg_frame() {
  printf "^pa(%d)^fg(green)(%s)^fg()" \
    ${_P_FRAME} \
    "${_FRAME}"
}

msg_tag() {
  printf "^pa(%d)^fg(yellow)::%s::^fg()" \
    ${_P_TAG} \
    "${_TAG}"
}

msg_tasks() {
  [ "${_TASK1}" -gt 0 ] && printf "^pa(%d)^fg(red)S:%d" \
    ${_P_TASK1} \
    "${_TASK1}"
  [ "${_TASK2}" -gt 0 ] && printf "^pa(%d)^fg(yellow)T:%d" \
    ${_P_TASK2} \
    "${_TASK2}"
}

msg_all() {
  msg_tag
  msg_focus
  msg_frame
  msg_date
  msg_tasks
  printf "\n"
}

handle_event() {
  event=$1
  shift
  case ${event} in
    date)
      ;;
    task)
      update_tasks $*
      ;;
    tag_changed)
      update_tag $*
      ;;
    focus_changed)
      update_focus $*
      update_frame
      ;;
    rule)
      update_frame
      ;;
    window_title_changed)
      update_focus $*
      ;;
    chord_enter)
      echo -n CHORD
      ;;
    chord_leave)
      echo -n LEAVE CHORD
      ;;
  esac
  msg_all
}

herbstclient --idle | while read line; do
  handle_event ${line}
done | dzen2 -x 0 -w 1366 -h 18 -fn "terminus:size=8" -y 750 -e 'button2=;' -ta l
#-x 850 -w 666 -h 18 -fn "terminus:size=8"

