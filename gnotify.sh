#!/bin/bash

INAME="bash"
ICON="/usr/share/icons/Numix-Circle/scalable/apps/$INAME.svg"
if [ ! -e $ICON ]; then
  ICON="terminal"
fi

# All arguments go into message variable
if (( $# > 0 )); then
  MESSAGE=$1
  while [ "$2" != "" ]; do
    shift
    MESSAGE="$MESSAGE $1"
  done
else
  echo "No message specified!"
  exit 1
fi

notify-send -u normal -a "$0" -t 5000 -i "$ICON" "$MESSAGE"
exit $?
