#!/bin/bash
# Summary: set proxy host by using different config files for squid
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.1

if [ "$#" -eq 0 ];then
    echo "Proxy setter"
    echo "Usage: $0 profile"
    echo "Current profiles: ada direct"
else
  if [[ $1 != "ada" && $1 != "direct" ]]; then
    echo "No valid profile found!"
    exit 1
  else
    PROFILE="$1"
  fi

  # PROXYHOSTNAME_FILE - where we store the hostname in use
  PROXY_FILE='/home/gta/.env/.proxyprofile'
  echo "$PROFILE" > $PROXY_FILE
  
  # set .wgetrc
  # set .curlrc
  # set /etc/apt.conf

  # shell settings
  echo "Future shell sessions will use that profile"

fi


