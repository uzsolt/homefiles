#!/usr/bin/env ruby

HLWM_WAIT="tag_changed"
URXVT_DIR="/home/zsolt/wallpapers/urxvt/"
WALLPAPER_DIR="/home/zsolt/wallpapers/"

TAGS = {
    "dox"   =>  "#{URXVT_DIR}/1366x768_Night-Wallpaper-1680x1050.jpg",
    "dev"   =>  "#{URXVT_DIR}/hacker_sym.jpg",
    "rpi"   =>  "#{URXVT_DIR}/rpi.jpg",
    "vps"   =>  "#{URXVT_DIR}/hacker_sym.jpg",
    "rss"   =>  "#{WALLPAPER_DIR}/map.png",
}

while true do
    output  =   `herbstclient --wait #{HLWM_WAIT}`
    new_tag =   output.gsub(/tag_changed\t(.*)\t0\n/,'\1')
    `DISPLAY=:0 feh --bg-fill #{TAGS[new_tag] || `cat /home/zsolt/logfiles/current_wallpaper`}`
end

