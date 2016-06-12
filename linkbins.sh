#!/bin/bash
# Summary: Link scripts in current directory to your local bin directory

BINDIR="/home/gta/.env/bin"
CURDIR=$(pwd)
FILETYPES="sh pl py rb"

echo "$CURDIR"
find ./ -maxdepth 1 -type f | sed 's/\.\///' > /tmp/linkbins 
for TYPE in $FILETYPES; do
  for FILE in $(cat /tmp/linkbins); do
    if [[ $FILE =~ ^.*\.$TYPE$ ]]; then
      ln -sfv "$CURDIR/$FILE" "$BINDIR/$FILE"
    fi
  done
done

