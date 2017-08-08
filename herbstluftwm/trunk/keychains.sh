#!/bin/sh

. /home/zsolt/.config/herbstluftwm/include.sh

URXVT_CONFIG="spawn urxvt-config-sh "
KC_TERM=terminal
KC_TERM_HOTKEY="${Winkey}+x"
KC_TERM_a="${URXVT_CONFIG} arch"
KC_TERM_b="${URXVT_CONFIG} freebsd"
KC_TERM_d="${URXVT_CONFIG} dox"
KC_TERM_n="${URXVT_CONFIG} bashburn tmux -L burn -2 new-session; source-file /home/zsolt/.config/tmux/tmux-burn.conf"
KC_TERM_t="${URXVT_CONFIG} torrent transmission-remote-cli"
KC_TERM_v="${URXVT_CONFIG} devel"
KC_TERM_x="${URXVT_CONFIG} main"

KC_TAG="change tag"
KC_TAG_HOTKEY="${Winkey}+t"
KC_TAG_x="use term"
KC_TAG_w="use web"
KC_TAG_r="use rss"
KC_TAG_d="use dox"
KC_TAG_v="use dev"
KC_TAG_t="use torrent"
KC_TAG_b="use bsd"
KC_TAG_l="use lowr"
KC_TAG_i="use loimp"
KC_TAG_m="use music"
KC_TAG_u="use util"

KC_MOVETAG="move to tag"
KC_MOVETAG_HOTKEY="${Winkey}+m"
KC_MOVETAG_x="move term"
KC_MOVETAG_w="move web"
KC_MOVETAG_r="move rss"
KC_MOVETAG_d="move dox"
KC_MOVETAG_v="move dev"
KC_MOVETAG_t="move torrent"
KC_MOVETAG_b="move bsd"
KC_MOVETAG_l="move lowr"
KC_MOVETAG_i="move loimp"
KC_MOVETAG_m="move music"
KC_MOVETAG_u="move util"

KC_WEB="open web"
KC_WEB_HOTKEY="${Winkey}+w"
browser=/home/zsolt/bin/mybrowser
KC_WEB_g="spawn  ${browser} mail.google.com/mail/u/0/#search/l%3Aunread"
KC_WEB_h="spawn  ${browser} hup.hu/user/4277/track"
KC_WEB_m="spawn  ${browser} www.bgrg.mozanaplo.hu"
KC_WEB_f="spawn  ${browser} www.facebook.com"

KC_LIST="get list"
KC_LIST_HOTKEY="${Winkey}+l"
KC_LIST_a="spawn /home/zsolt/.config/herbstluftwm/scripts/my-dmenu"
KC_LIST_c="spawn /home/zsolt/.config/herbstluftwm/scripts/change_client.sh"
KC_LIST_t="spawn /home/zsolt/.config/herbstluftwm/scripts/change_tag.sh"
KC_LIST_m="spawn /home/zsolt/.config/herbstluftwm/scripts/mpd-playlist.sh"

KC_MUNKAKOZ="munkaköz"
KC_MUNKAKOZ_HOTKEY="${Winkey}+k"
KC_MUNKAKOZ_n="spawn /home/zsolt/.config/herbstluftwm/scripts/munkakoz_nevezes_lista"

KC_SPLIT="split"
KC_SPLIT_HOTKEY="${Winkey}+s"
KC_SPLIT_h="split horizontal 0.5"
KC_SPLIT_v="split vertical 0.5"
KC_SPLIT_r="remove"

KC_MOVEFRAME="move frame"
KC_MOVEFRAME_HOTKEY="${Winkey}+f"
KC_MOVEFRAME_a="shift left"
KC_MOVEFRAME_s="shift right"
KC_MOVEFRAME_q="shift up"
KC_MOVEFRAME_y="shift down"

float_off="chain + floating off + "
KC_LAYOUT="layout"
KC_LAYOUT_HOTKEY="${Winkey}+a"
KC_LAYOUT_v="${float_off} set_layout vertical"
KC_LAYOUT_h="${float_off} set_layout horizontal"
KC_LAYOUT_m="${float_off} set_layout max"
KC_LAYOUT_g="${float_off} set_layout grid"
KC_LAYOUT_r="rotate"
KC_LAYOUT_f="floating on"

KC_MPD="musicpd"
KC_MPD_HOTKEY="${Winkey}+p"
KC_MPD_space="spawn mpc toggle"
KC_MPD_n="spawn mpc next"
KC_MPD_s="spawn mpc stop"
KC_MPD_p="spawn mpc play"
KC_MPD_i="spawn /home/zsolt/.config/herbstluftwm/scripts/mpd-info.sh"

KC_VOLUME="volume"
KC_VOLUME_HOTKEY="${Winkey}+v"
KC_VOLUME_q="spawn mixer vol +5"
KC_VOLUME_a="spawn mixer vol -5"

KEYCHAINS=`set | sed -n "/^KC_/ s@KC_\([^_=]*\).*@\1@p" | uniq`

for kc in ${KEYCHAINS}; do
    #echo ">>> ${kc}"
    curr=`set | sed -n "/^KC_${kc}_HOTKEY/d ; \
        /^KC_${kc}/ s@KC_${kc}_\([^_=]*\).*@\1@p"`

    # create unbinds
    del="${chain} emit_hook ${hook_leave_keychain} \
        ${chain} keyunbind Escape" 
    for x in ${curr}; do
        #echo "    ${x}"
        del="${del} ${chain} keyunbind ${x}"
    done

    # create chains
    eval hc_command=\"keybind \$KC_${kc}_HOTKEY chain \
        ${chainm} emit_hook ${hook_enter_keychain} \$KC_${kc}\"
    for x in ${curr}; do
        eval hc_command=\"${hc_command} ${chainm} \
            keybind ${x} chain ${del} \
            ${chain} \${KC_${kc}_$x}\"
    done
    hc_command="${hc_command} ${chainm} keybind Escape chain ${del}"
    herbstclient ${hc_command}
done


