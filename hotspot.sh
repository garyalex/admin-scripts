#!/bin/bash

LOGS=~/logs/hotspot.log
WLAN="wlp5s0"
ETH0="enp9s0"

if [ "$#" -eq 0 ];then
        echo "AP Hotspot for phones"
        echo "Usage: $0 [ on | off | restart ]"
else
        while [ "$2" != "" ]; do
                shift
        done       
        if [ $1 = "on" ]; then 
                echo "Turning hostpot on"
                sudo create_ap --daemon --no-virt -c 6 $WLAN $ETH0 monroeAP 9876ALEX12345 &>~/logs/hotspot.log
                echo "Use setsshtunnel to setup ssh tunnel as needed"
        elif [ $1 = "off" ]; then
                echo "Turning hotspot off"
                sudo create_ap --stop $WLAN 
                ps aux | grep adalind | grep 8080 | awk '{ print $2; }' | xargs --no-run-if-empty kill
                ps aux | grep hostapd | awk '{ print $2; }' | xargs --no-run-if-empty kill
                ps aux | grep create_ap | awk '{ print $2; }' | xargs --no-run-if-empty kill
                sudo create_ap --fix-unmanaged
                echo "Use setsshtunnel to setup ssh tunnel as needed"
        elif [ $1 = "restart" ]; then
                echo "Turning hotspot off"
                sudo create_ap --stop $WLAN 
                ps aux | grep adalind | grep 8080 | awk '{ print $2; }' | xargs --no-run-if-empty kill
                ps aux | grep hostapd | awk '{ print $2; }' | xargs --no-run-if-empty kill
                ps aux | grep create_ap | awk '{ print $2; }' | xargs --no-run-if-empty kill
                sudo create_ap --fix-unmanaged
                echo "Turning hotspot on"
                echo "Use setsshtunnel to setup ssh tunnel as needed"
                sudo create_ap --daemon --no-virt -c 6 $WLAN $ETH0 monroeAP 9876ALEX12345 &>~/logs/hotspot.log
        else
                echo "AP Hotspot for phones"
                echo "Usage: $0 [ on | off | restart ]"
        fi
fi
