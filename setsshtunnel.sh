#!/usr/bin/env bash
# Summary: set ssh tunnel using master and control sockets
# Usage: set-proxy.zsh [ hostname | none ] 
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.2

function usage {
echo "SSH Tunnel setter"
echo "Usage: $0 hostname [ on | off ]"
exit 1
}

if [ "$#" -eq 0 ]; then
  usage
fi

if [[ "$1" == "" || "$2" == "" ]]; then
  usage
fi
  
# variables for ssh tunnel
hostname="$1"
portlist="8080 10022 10080 5050 8989"
socketfile="/tmp/gta-sshtunnel"
ssh_host_file="/tmp/gta-sshtunnel.txt"

case $2 in
on)
  for port in $portlist 
  do
    portsockfile="$socketfile-$port"
    echo "Starting SSH Tunnel Host: $hostname Port: $port File: $portsockfile"
    echo "ssh -M -S $portsockfile -Cfo ExitOnForwardFailure=yes -NL 0.0.0.0:$port:localhost:$port $hostname"
    ssh -M -S $portsockfile -Cfo ExitOnForwardFailure=yes -NL 0.0.0.0:$port:localhost:$port $hostname
    if [ $? -eq 0 ]; then
      echo "Setup successful"
    fi
  done
  ;;
off)
  for port in $portlist 
  do
    echo "Stoppimg SSH Tunnel Port: $port"
    portsockfile="$socketfile-$port"
    if [ -e $portsockfile ]; then
      ssh -S $portsockfile -O stop $hostname
    fi
  done
  ;;
*)
  usage
  ;;
esac
