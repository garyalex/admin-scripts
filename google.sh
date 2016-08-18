#!/bin/bash
# Author: Gary Alexander

URL="https://www.google.ae/search?q="

if (( $# > 0 )); then
  MESSAGE=$1
  while [ "$2" != "" ]; do
    shift
    MESSAGE="$MESSAGE+$1"
  done
  ARGS="$URL$MESSAGE"
  echo "Opening: $ARGS"
  xdg-open "$ARGS"
else
  echo "Please provide search terms as arguments!"
fi
