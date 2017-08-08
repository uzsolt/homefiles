#!/bin/sh

_TAG=""
_FOCUS=""
_FRAME=""

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
  _FRAME="${F_INDEX}/${COUNT}"
}

# $1 - tag
# $2 - monitor
update_tag() {
  _TAG="$1"
}

msg_focus() {
  printf "[ %s ]" "${_FOCUS}"
}

msg_frame() {
  printf "(%s)" "${_FRAME}"
}

msg_tag() {
  printf "%s" " ${_TAG}"
}

msg_all() {
  msg_focus ; printf "%s" " "
  msg_tag   ; printf "%s" " "
  msg_frame
  printf "\n"
}

handle_event() {
  event=$1
  shift
  case ${event} in
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
done | dzen2 -x 0 -w 1366 -h 18 -fn "terminus:size=8" -y 750 -e 'button2=;'
#-x 850 -w 666 -h 18 -fn "terminus:size=8"

