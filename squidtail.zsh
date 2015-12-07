#!/bin/zsh
# Summary: script to tail squid access log and pipe to ccze (log colors)
# Usage: squidtail.zsh
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.1

# sudo for access to log 
sudo tail -f /var/log/squid3/access.log | ccze -A -C
