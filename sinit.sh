#!/usr/bin/env zsh

autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
  colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]'
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

HOSTNAME=`hostname | tr '[:lower:]' '[:upper:]'`
UPTIME="$(uptime)"
UNAME=`uname -a`

clear
echo "$HOSTNAME" | toilet --gay -f mono9 -t 

cd $HOME
echo "$WHITE UNAME: $UNAME $RESET"
echo "$BLUE UPTIME: $UPTIME $RESET"
echo "$CYAN CURRENT DIR: $RED $HOME $RESET"
echo

