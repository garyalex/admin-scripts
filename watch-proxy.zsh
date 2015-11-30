#!/usr/bin/env zsh
# Summary: Proxy status watcher - status of ssh tunnel & local squid proxy
# Usage: watch-proxy.zsh 
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.1

autoload colors
if [[ "$terminfo[colors]" -gt 8 ]]; then
  colors
fi
for COLOR in RED GREEN YELLOW BLUE MAGENTA CYAN BLACK WHITE; do
  eval $COLOR='$fg_no_bold[${(L)COLOR}]'
  eval BOLD_$COLOR='$fg_bold[${(L)COLOR}]'
done
eval RESET='$reset_color'

PROXY_FILE="/var/local/gta-proxy"
SSHTUNNEL_FILE="/var/local/gta-sshtunnel"
PROXY_LOG="/var/log/squid3/access.log"

# Current Proxy parent
if [[ -f $PROXY_FILE ]]; then
  PROXY_PARENT=$(cat $PROXY_FILE)
else
  PROXY_PARENT="-- NOT RUNNING? --"
fi

SSHTUN_PID=$(cat $SSHTUNNEL_FILE)
