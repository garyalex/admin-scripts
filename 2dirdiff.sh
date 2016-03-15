#!/bin/bash
# Shell script 
# Gary Alexander garyalex@gmail.com github.com/garyalex
# 
# Summary:
#

if [[ -z "$1" && -z "$2" ]]; then
  echo "Usage: $0 dir1 dir2"
  exit 1
fi

# Skip files in $1 which are symlinks
for f in $(find "$1"/* ! -type l)
do
  # Suppress details of differences
  diff -rq "$f" "$2"/${f##*/}
done
