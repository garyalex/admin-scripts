#!/usr/bin/env zsh
# Source file for src external

autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
  colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]'
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

clear
echo "GTA SRC" | toilet --gay -f mono9 -t 

cd /home/gta/Documents/scripting/src-gta/
echo "$BOLD_YELLOWSRC DIR: $RESET$CYAN$(pwd)$RESET"
echo "$GREEN"
ls 
echo
echo "$BOLD_YELLOW\- WELCOME TO THE JUNGLE, WE GOT FUN AND GAMES$RESET"
echo

