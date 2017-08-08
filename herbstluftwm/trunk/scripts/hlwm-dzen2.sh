#!/usr/bin/env bash

BAT_LIFE=""
BAT_STATUS=""
CURRENT_CHAIN=""
CURRENT_FOCUS=""
CURRENT_FRAME=0
CURRENT_TAG=""
SWAP_INFO=""
TAGLIST=""
UNREAD_ITEMS=0
UNREAD_EMAILS=0

TW_VERYURGENT=0
TW_URGENT=0
TW_LURGENT=0

# Current tag
function set_current_tag() {
    CURRENT_TAG=$1
}

function set_battery_life() {
    BAT_LIFE=$1
}

function set_battery_status() {
    BAT_STATUS=$1
}

# Current keychain
function set_current_chain() {
    if [ -z "$*" ]; then
        CURRENT_CHAIN=""
    else
        CURRENT_CHAIN="[$*]"
    fi
}

function set_current_frame() {
    F_COUNT=$(herbstclient attr tags.focus.curframe_wcount)
    if [ ${F_COUNT} -gt 1 ]; then
        F_INDEX=$(herbstclient attr tags.focus.curframe_windex)
        F_INDEX=$((F_INDEX+1))
        CURRENT_FRAME=${F_INDEX}/${F_COUNT}
    else
        CURRENT_FRAME=""
    fi
}

function set_current_focus() {
    if [ -n "$*" ]; then
        CURRENT_FOCUS="<< $(echo $* | sed "s@ - Mozilla Firefox@@ ; s@\(.\{60\}\).*@\1...@") >>"
    else
        CURRENT_FOCUS=""
    fi
}

function set_taskwarrior() {
    TW_VERYURGENT=$1
    TW_URGENT=$2
    TW_LURGENT=$3
}

TL_CURRENT_BG=green
TL_BG="#333333"
function set_taglist() {
    TAGLIST=$(herbstclient tag_status | \
        sed "s@\#\([a-z]*\)@^bg(${TL_CURRENT_BG})^fg(black)\1^bg(${TL_BG})@g ; \
            s@\:\([a-z]*\)@^bg(${TL_BG})^fg(black)\1^bg(${TL_BG})@g ; \
            s@\.[a-z]*@@g" | tr "\t" " ")
}

function set_unread_emails() {
    UNREAD_EMAILS=$(grep "<entry>" ~/logfiles/gmail-unread | wc -l | sed "s@^ *@@")
}

function set_unread_items() {
    TMP=$(head -n 1 ~/logfiles/newsbeuter-unread-items)
    if [ -n "${TMP}" ]; then
        UNREAD_ITEMS=${TMP}
    fi
}

function set_swap_status() {
    if [ $1 -gt 0 ]; then
        SWAP_INFO="Sw:$1%"
    else
        SWAP_INFO=""
    fi
}

c_use_battery="#ff0000"
function print_bat() {
    if [ "${BAT_STATUS}" -eq 1 ]; then
        msg_print ${c_use_battery} "#000000" "DC ${BAT_LIFE}%"
    elif [ "${BAT_LIFE}" -lt 20 ]; then
        msg_print ${c_use_battery} "#000000" "AC ${BAT_LIFE}%"
    fi
}

function print_tw() {
    infix=""
    if [ ${TW_VERYURGENT} -gt 0 ]; then
        msg_print "#ffffff" "#ff0000" "${TW_VERYURGENT}"
    fi
    if [ ${TW_URGENT} -gt 0 ]; then
        msg_print "#ff0000" "#000000" "${TW_URGENT}"
    fi
    if [ ${TW_LURGENT} -gt 0 ]; then
        msg_print "#aaaaaa" "#000000" "${infix}${TW_LURGENT}"
    fi
}

c_current_frame="#aaaaaa"
function print_current_frame() {
    if [ -n "${CURRENT_FRAME}" ]; then
        msg_print ${c_current_frame} "#000000" "(${CURRENT_FRAME})"
    fi
}

function msg_print() {
    echo -n "^fg($1)^bg($2)$3 "
}

c_current_tag="#00ff00"
c_current_chain="#000000"
c_current_focus="#ffffff"
c_unread_items="#999999"
function print_msg() {
    print_tw
    print_bat
    msg_print ${c_use_battery} "#000000" "${SWAP_INFO}"
    msg_print ${c_current_tag} "#000000" "${CURRENT_TAG}"
    #msg_print ${c_current_tag} "#000000" "${TAGLIST}"
    print_current_frame
    if [ -n "${CURRENT_CHAIN}" ]; then
        msg_print ${c_current_chain} "#ffff00" "${CURRENT_CHAIN}"
    fi
    msg_print ${c_current_focus} "#000000" "${CURRENT_FOCUS}"
    if [ "${UNREAD_ITEMS}" -gt 0 ]; then
        msg_print ${c_unread_items} "#000000" "R:${UNREAD_ITEMS}"
    fi
    if [ "${UNREAD_EMAILS}" -gt 0 ]; then
        msg_print ${c_unread_items} "#000000" "M:${UNREAD_EMAILS}"
    fi
    echo
}

function cleanup() {
    kill $(jobs -p) 2>/dev/null
}

function init() {
    CURRENT_TAG=$( herbstclient tag_status | sed "s@.*\#\([a-z]*\).*@\1@" )
    set_current_focus "$(herbstclient get_attr clients.focus.title)"
    BAT=($(sysctl hw.acpi.battery.{life,state} | sed "s@.*: @@"))
    set_battery_life ${BAT[0]}
    set_battery_status ${BAT[1]}
    set_current_frame
    set_taglist
    set_unread_items
    set_unread_emails
}

trap cleanup INT TERM HUP
init
print_msg

herbstclient --idle | while read line; do
    ARGS=( $line )
    logger -t herbstluftwm ${ARGS[@]}
    case ${ARGS[0]} in
        chain_enter)
            set_current_chain ${ARGS[@]:1}
            ;;
        chain_leave)
            set_current_chain ""
            ;;
        tag_changed)
            set_current_tag ${ARGS[1]}
            #set_taglist
            ;;
        focus_changed|window_title_changed)
            set_current_focus ${ARGS[@]:2}
            set_current_frame
            ;;
        user_battery)
            set_battery_status ${ARGS[1]}
            set_battery_life ${ARGS[2]}
            ;;
        user_battery_life)
            set_battery_life ${ARGS[1]}
            ;;
        user_battery_status)
            set_battery_status ${ARGS[1]}
            ;;
        user_newsbeuter)
            set_unread_items
            ;;
        user_gmail)
            set_unread_emails
            ;;
        user_swap)
            set_swap_status ${ARGS[1]}
            ;;
        user_taskwarrior)
            set_taskwarrior ${ARGS[1]} ${ARGS[2]} ${ARGS[3]}
            ;;
        quit)
            if [ $# -gt 0 ]; then
                kill -9 $*
                pkill -9 wait_on
            fi
            exit
            ;;
    esac
    print_msg
done

