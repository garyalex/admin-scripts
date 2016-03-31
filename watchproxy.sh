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

PROXY_FILE="/tmp/gta-squidhost"
SSHTUNNEL_FILE="/tmp/gta-sshtunnel"
SSH_HOST_FILE="/tmp/gta-sshtunnel.txt"

while true
do
  clear
  # Current Proxy parent
  if [ -f "$PROXY_FILE" ]
  then
    PROXY_PARENT="$(cat $PROXY_FILE | tr '[:lower:]' '[:upper:]')"
  else
    PROXY_PARENT="-- NOT RUNNING? --"
  fi

  # SSH Tunnel
  if [[ -f $SSHTUNNEL_FILE && -f $SSH_HOST_FILE ]]; then
    SSH_HOST=$(cat $SSH_HOST_FILE)
    SSH_STATUS="$(ssh -S $SSHTUNNEL_FILE -O check $SSH_HOST)"
    echo "SSH HOST: $SSH_HOST STATUS: $SSH_STATUS"
  else
    SSH_HOST="none"
    SSH_STATUS="not running"
    echo "SSH HOST: $SSH_HOST STATUS: $SSH_STATUS"
  fi

  # Print the status
  echo "PROXY WATCH" | toilet -F gay -f smblock -t
  echo
  echo "$BOLD_WHITE PROXY PROFILE -$BOLD_YELLOW $PROXY_PARENT $RESET"
  echo "$BLUE=====================================$RESET"
  echo "$BOLD_CYAN SSH TUNNEL -$BOLD_GREEN $SSH_STATUS $RESET"
  echo "$BLUE=====================================$RESET"
  echo 

  # If single mode exit, otherwise loop
  if [[ $1 == "single" ]]; then
    exit 0
  else
    sec=60
    while [ $sec -ge 0 ]; do
      echo -ne "COUNTDOWN TO REFRESH: $sec SECS\033[0K\r"
      let "sec=sec-1"
      sleep 1
    done
  fi
done
