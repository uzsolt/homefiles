set keychains = (\
    "${Winkey}+a/layout.kc_layout"\
    "${Winkey}+f/move frame.kc_frame"\
    "${Winkey}+i/info.kc_info"\
    "${Winkey}+l/get list.kc_list"\
    "${Winkey}+m/move tag.kc_movetag"\
    "${Winkey}+p/musicpd.kc_musicpd"\
    "${Winkey}+s/split.kc_split"\
    "${Winkey}+t/change tag.kc_changetag"\
    "${Winkey}+v/volume.kc_vol"\
    "${Winkey}+w/open web.kc_web"\
    "${Winkey}+x/terminal.kc_term"\
)

set kc_frame = (\
    "'a/shift left'"\
    "'s/shift right'"\
    "'q/shift up'"\
    "'y/shift down'"\
)

set kc_info = (\
    "'n/spawn dzen-calendar'"\
    "'w/spawn ${HLWM_DIR}/scripts/info-win.sh'"\
    "'m/spawn ${HLWM_DIR}/scripts/info-mpd.sh'"\
    "'v/spawn ${HLWM_DIR}/scripts/info-vol.sh'"\
)

set float_off="chain + floating off + "
set kc_layout = (\
    "'v/${float_off} set_layout vertical'"\
    "'h/${float_off} set_layout horizontal'"\
    "'m/${float_off} set_layout max'"\
    "'g/${float_off} set_layout grid'"\
    "'r/rotate'"\
    "'f/floating on'"\
)

set kc_list = (\
    "'a/spawn /home/zsolt/.config/herbstluftwm/scripts/my-dmenu'"\
    "'c/spawn /home/zsolt/.config/herbstluftwm/scripts/change_client.sh'"\
    "'t/spawn /home/zsolt/.config/herbstluftwm/scripts/change_tag.sh'"\
    "'m/spawn /home/zsolt/.config/herbstluftwm/scripts/mpd-playlist.sh'"\
)

set mpc="spawn mpc"
set kc_musicpd = (\
    "'space/${mpc} toggle'"\
    "'n/${mpc} next'"\
    "'s/${mpc} stop'"\
    "'p/${mpc} play'"\
)

set kc_split = (\
    "'h/split horizontal 0.5'"\
    "'v/split vertical 0.5'"\
    "'r/remove'"\
)

set mixer="spawn mixer"
set kc_vol = (\
    "'q/${mixer} vol +5'"\
    "'a/${mixer} vol -5'"\
)

set browser="spawn /home/zsolt/bin/mybrowser"
set kc_web = (\
    "'g/${browser} mail.google.com/mail/u/0/#search/l%3Aunread'"\
    "'h/${browser} hup.hu/user/4277/track'"\
    "'m/${browser} www.bgrg.mozanaplo.hu'"\
    "'f/${browser} www.facebook.com'"\
)

set urxvt="spawn urxvt-config-sh"
set kc_term = (\
    "'b/${urxvt} freebsd'"\
    "'d/${urxvt} dox'"\
    "'n/${urxvt} bashburn tmux -L burn -2 new-session; source-file /home/zsolt/.config/tmux/tmux-burn.conf'"\
    "'v/${urxvt} devel'"\
    "'x/${urxvt} main'"\
    "'p/${urxvt} vps ssh uzsolt.hu'"\
)

