HLWM_DIR=/home/zsolt/.config/herbstluftwm
Mod=Mod1
Winkey=Mod4

chainm="+++"
chain=","
hook_enter_keychain="chain_enter"
hook_leave_keychain="chain_leave"


hc() {
    herbstclient "$@"
}

