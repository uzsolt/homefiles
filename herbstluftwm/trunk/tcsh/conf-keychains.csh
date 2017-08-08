set keychains = (\
    "${Winkey}+a/layout.kc_layout"\
    "${Winkey}+w/open web.kc_web"\
    "${Winkey}+f/move frame.kc_frame"\
    "${Winkey}+h/herbst.kc_herbst"\
    "${Winkey}+i/info.kc_info"\
    "${Winkey}+l/get list.kc_list"\
    "${Winkey}+m/move tag.kc_movetag"\
    "${Winkey}+o/torrent.kc_torrent"\
    "${Winkey}+p/musicpd.kc_musicpd"\
    "${Winkey}+s/split.kc_split"\
    "${Winkey}+t/change tag.kc_changetag"\
    "${Winkey}+v/volume.kc_vol"\
    "${Winkey}+x/terminal.kc_term"\
    "${Winkey}+c/client.kc_client"\
)

set kc_frame = (\
    "'a/shift left'"\
    "'s/shift right'"\
    "'q/shift up'"\
    "'y/shift down'"\
)

set kc_herbst = (\
    "'2/spawn xdotool click 2'"\
    "'1/spawn xdotool click 1'"\
    "'t/spawn ${HLWM_DIR}/scripts/hlwm_translate.sh'"\
    "'c/spawn ${HLWM_DIR}/scripts/hlwm_calc.sh'"\
)

set kc_info = (\
    "'m/spawn ${HLWM_DIR}/scripts/info-mpd.sh'"\
    "'n/spawn dzen-calendar'"\
    "'t/spawn ${HLWM_DIR}/scripts/info-torrent.sh'"\
    "'v/spawn ${HLWM_DIR}/scripts/info-vol.sh'"\
    "'w/spawn ${HLWM_DIR}/scripts/info-win.sh'"\
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
    "'b/${browser} http://uzsolt.hu/online-bookmarks/sidebar.php'"\
    "'g/${browser} mail.google.com/mail/u/0/#search/l%3Aunread'"\
    "'h/${browser} hup.hu/user/4277/track'"\
    "'m/${browser} www.bgrg.mozanaplo.hu'"\
    "'f/${browser} www.facebook.com'"\
    "'t/${browser} http://rpi:9091/transmission/web/'"\
    "'r/${browser} https://direktnet.raiffeisen.hu/rai/direktnet/home.do'"\
)

#; source-file /home/zsolt/.config/tmux/tmux-burn.conf'"\
set urxvt="spawn urxvt-config-sh"
set kc_term = (\
    "'b/${urxvt} freebsd'"\
    "'d/${urxvt} dox'"\
    "'n/${urxvt} bashburn tmux -L burn -2 '"\ #source-file /home/zsolt/.config/tmux/tmux-burn.conf'"\
    "'v/${urxvt} devel'"\
    "'x/${urxvt} main'"\
    "'p/${urxvt} vps ssh uzsolt.hu'"\
    "'i/${urxvt} rpi ssh 192.168.2.102'"\
)

set kc_client = (\
    "'c/close'"\
    "'x/close'"\
)

