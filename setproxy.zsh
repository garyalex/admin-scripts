#!/usr/bin/env zsh
# Summary: set proxy host by using different config files for squid
# Usage: set-proxy.zsh [ hostname | none ] 
# Author: Gary Alexander (https://github.com/garyalex)
# Version: 0.0.1

if [ "$#" -eq 0 ];then
    echo "Proxy setter"
    echo "Usage: $0 profile"
    echo "Current profiles: ucs ada direct"
else
  # setup main squid file and template file
  squidconf="/etc/squid3/squid.conf"
  if [[ $1 != "ada" && $1 != "ucs" && $1 != "direct" ]]; then
    echo "No valid profile found!"
    exit 1
  else
    PROFILE="$1"
    templateconf="$squidconf.$PROFILE"
  fi

  # cp template to squid conf
  # check if template exists
  if [ ! -f $templateconf ]; then
    echo "ERROR: no such file $templateconf"
    exit 1
  fi 
  # PROXYHOSTNAME_FILE - where we store the hostname in use
  PROXY_FILE='/tmp/gta-squidhost'
  rm -rf $PROXY_FILE
  echo "$PROFILE" > $PROXY_FILE
  
  sudo cp $templateconf $squidconf
  sudo systemctl reload squid3.service || \
    sudo systemctl start squid3.service
  # set .wgetrc
  # set .curlrc
  # set /etc/apt.conf

  # shell settings
  HTTP_PROXY="http://garya:pw123@192.168.116.235:3000/"
  HTTPS_PROXY="http://garya:pw123@192.168.116.235:3000/"
  FTP_PROXY="http://garya:pw123@192.168.116.235:3000/"
  http_proxy="http://garya:pw123@192.168.116.235:3000/"
  https_proxy="http://garya:pw123@192.168.116.235:3000/"
  ftp_proxy="http://garya:pw123@192.168.116.235:3000/"
  export HTTP_PROXY HTTPS_PROXY FTP_PROXY
  export http_proxy https_proxy ftp_proxy

  # gnome proxy settings
  gsettings set org.gnome.system.proxy mode manual
  gsettings set org.gnome.system.proxy.http host "127.0.0.1"
  gsettings set org.gnome.system.proxy.http port "8080"
  gsettings set org.gnome.system.proxy.https host "127.0.0.1"
  gsettings set org.gnome.system.proxy.https port "8080"
fi
