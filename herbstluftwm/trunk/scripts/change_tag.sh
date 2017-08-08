#!/bin/sh

NEW_TAG=$(herbstclient tag_status | \
    grep -o "[:\#][a-z]*" | sed "s@^.@@" | sort | rofi -dmenu -l 10 -p 'tag: ')

if [ $? -eq 0 ]; then
    herbstclient use ${NEW_TAG}
fi

