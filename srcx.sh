# Source file for src external
COL_YELLOW="$(tput setaf 3)"
COL_OTHER="$(tput setaf 6)"
COL_NORM="$(tput setaf 9)"
SET_BOLD="$(tput bold)"
UNSET_BOLD="$(tput sgr0)"

echo "EXT SRC" | toilet --gay -f mono9 -t 

cd /home/gta/Documents/scripting/src-external/
DIR="$(pwd)"
echo "${SET_BOLD}${COL_YELLOW}SRC DIR: ${DIR}${COL_NORM}${UNSET_BOLD}"
echo
ls 
echo
echo "${SET_BOLD}${COL_YELLOW}## ${COL_OTHER}~/bin/updategitrepos.sh ${DIR}${COL_YELLOW} to do updates${COL_NORM}${UNSET_BOLD}"
echo

