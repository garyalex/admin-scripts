#!/usr/bin/env zsh
# Summary: set ssh tunnel using master and control sockets
# Usage: set-proxy.zsh [ hostname | none ] 
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.1

if [ "$#" -eq 0 ];then
  echo "SSH Tunnel setter"
  echo "Usage: $0 hostname [ on | off ]"
  exit 1
fi
  
# variables for ssh tunnel
hostname="$1"
socketfile="/tmp/gta-sshtunnel"
running=0
if [ -e $socketfile ]; then
  ssh -S $socketfile -O check $hostname
  if [ $? -eq 0 ]; then
    running=1
  fi
else
  echo "No socketfile $socketfile"
fi

if [[ $2 == "on" && $running -eq 0 ]]; then
  # start it
  ssh -M -S $socketfile -Cfo ExitOnForwardFailure=yes -NL 8083:localhost:8080 $hostname
elif [[ $2 == "on" && $running -eq 1 ]]; then
  # already running
  echo "Error: already running"
  exit 1
elif [[ $2 == "off" && $running -eq 0 ]]; then
  # already stopped
  echo "Error: already stopped"
  exit 1
elif [[ $2 == "off" && $running -eq 1 ]]; then
  # stop it
  ssh -S $socketfile -O stop $hostname
fi 
