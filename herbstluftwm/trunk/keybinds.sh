#!/bin/sh

. ~/.config/herbstluftwm/include.sh

hc keyunbind --all
hc_quit() {
    herbstclient emit_hook quit
}

hc keybind $Mod-Shift-q chain + emit_hook quit + quit
hc keybind $Mod-Shift-r reload
hc keybind $Mod-Shift-c close
hc keybind $Mod-Return spawn urxvt

# cycle through tags
hc keybind $Mod-period use_index +1 --skip-visible
hc keybind $Mod-comma  use_index -1 --skip-visible
hc keybind $Mod-Right use_index +1 --skip-visible
hc keybind $Mod-Left  use_index -1 --skip-visible

# layouting
hc keybind $Mod-space cycle_layout 1
hc keybind $Mod-s floating toggle
hc keybind $Mod-p pseudotile toggle

# resizing
RESIZESTEP=0.05
hc keybind $Mod-Control-h resize left +$RESIZESTEP
hc keybind $Mod-Control-j resize down +$RESIZESTEP
hc keybind $Mod-Control-k resize up +$RESIZESTEP
hc keybind $Mod-Control-l resize right +$RESIZESTEP

# focus
hc keybind $Mod-Tab cycle
hc keybind $Winkey-Tab cycle_frame
hc keybind $Winkey-Left focus left
hc keybind $Mod-j focus down
hc keybind $Mod-k focus up
hc keybind $Winkey-Right focus right
hc keybind $Mod-i jumpto urgent
hc keybind $Mod-Shift-h shift left
hc keybind $Mod-Shift-j shift down
hc keybind $Mod-Shift-k shift up
hc keybind $Mod-Shift-l shift right

hc keybind $Mod-Escape use_previous

