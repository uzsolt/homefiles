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

_BC_DEFAULT="#111111"
_FC_DATE="white"
_BC_DATE="${_BC_DEFAULT}"
_FC_FOCUS="black"
_BC_FOCUS="gray"
_FC_FRAME="green"
_BC_FRAME="${_BC_DEFAULT}"
_FC_TAG="yellow"
_BC_TAG="${_BC_DEFAULT}"
_FC_TASK1="red"
_BC_TASK1="${_BC_DEFAULT}"
_FC_TASK2="yellow"
_BC_TASK2="${_BC_DEFAULT}"

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

# $1 - position
# $2 - fg color
# $3 - bg color
# $4- - message
msg() {
  m_pos="$1";shift
  m_fgcolor="$1";shift
  m_bgcolor="$1";shift
  m_msg=$@

  printf '^pa(%d)^fg(%s)^bg(%s)%s^bg()^fg()' \
    ${m_pos} ${m_fgcolor} ${m_bgcolor} "${m_msg}"
}

msg_date() {
  msg "${_P_DATE}" "${_FC_DATE}" "${_BC_DATE}" "`date +'%H:%M (%b. %d., %a)'`"
}

msg_focus() {
  msg "${_P_FOCUS}" "${_FC_FOCUS}" "${_BC_FOCUS}" "${_FOCUS}"
}

msg_frame() {
  msg "${_P_FRAME}" "${_FC_FRAME}" "${_BC_FRAME}" "${_FRAME}"
}

msg_tag() {
  msg "${_P_TAG}" "${_FC_TAG}" "${_BC_TAG}" "::${_TAG}::"
}

msg_tasks() {
  echo ${_TASK1} ${_TASK2} >&2
  [ "${_TASK1}" -gt 0 ] && \
    msg ${_P_TASK1} "${_FC_TASK1}" "${_BC_TASK1}" "S:${_TASK1}"
  [ "${_TASK2}" -gt 0 ] && \
    msg ${_P_TASK2} "${_FC_TASK2}" "${_BC_TASK2}" "T:${_TASK2}"
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
