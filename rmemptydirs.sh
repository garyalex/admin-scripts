#!/bin/bash

asksure() {
echo -n "Are you sure (Y/N)? "
while read -r -n 1 -s answer; do
  if [[ $answer = [YyNn] ]]; then
    [[ $answer = [Yy] ]] && retval=0
    [[ $answer = [Nn] ]] && retval=1
    break
  fi
done

echo # just a final linefeed, optics...

return $retval
}

echo "Empty directories to delete:"
find . -depth -type d -empty
echo

### using it
if asksure; then
  echo "Removing directories..."
  find . -depth -type d -empty -exec rmdir -v {} \;
else
  echo "Aborting."
fi
