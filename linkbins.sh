#!/bin/bash
# Summary: Link scripts in current directory to your local bin directory

BINDIR="/usr/local/bin"
CURDIR=$1
FILETYPES="sh pl py rb"

if [ ! -d "$CURDIR" ]; then
  echo "Not a directory!"
  exit 1
fi

cd "$CURDIR"
find ./ -maxdepth 1 -type f | sed 's/\.\///' > /tmp/linkbins
for TYPE in $FILETYPES; do
  for FILE in $(cat /tmp/linkbins); do
    if [[ $FILE =~ ^.*\.$TYPE$ ]]; then
      ln -sfv "$CURDIR/$FILE" "$BINDIR/$FILE"
    fi
  done
done

exit 0
