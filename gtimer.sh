#!/bin/bash

ICON="/usr/share/icons/Numix-Circle/scalable/apps/xfce4-logo.svg"
MESSAGE="$2"
TIME="$1"

sleep "$TIME"
notify-send -u critical -a "$0" -i "$ICON" "$MESSAGE"
