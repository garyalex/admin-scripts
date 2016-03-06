#!/bin/bash
# Purpose: Set correct webserver files and dir permissions
# Author: Gary Alexander
# -------------------------------------------------------------------------------------------------

_dir="${1:-.}"
_fperm="0640"
_dperm="0755"
_ugperm="gta:users"
_chmod="/bin/chmod"
_chown="/bin/chown"
_find="/usr/bin/find"
_xargs="/usr/bin/xargs"
 
echo "I will change the file permission for webserver dir and files to restrctive read-only mode for \"$_dir\""
read -p "Your current dir is ${PWD}. Are you sure (y / n) ?" ans
if [ "$ans" == "y" ]
then
  echo "Changing file onwership to $_ugperm for $_dir..."
  sudo $_chown -R "${_ugperm}" "$_dir"
  # If it's a script file make it executabl

 
  echo "Setting $_fperm permission for $_dir directory...."
  sudo $_chmod -R "${_fperm}" "$_dir"
 
  echo "Setting $_dperm permission for $_dir directory...."
  sudo sh -c "$_find """$_dir""" -type d -print0 | $_xargs -0 -I {} $_chmod $_dperm {}"
fi

