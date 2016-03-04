#!/bin/bash
#design

bold=$(tput bold)
normal=$(tput sgr0)
red='tput setaf 1'
green='tput setaf 2'

#apt-get update
echo "Fetching new package lists"

declare -a INSTALL
INSTALL=( unrar unzip git)

for i in "${INSTALL[@]}"
do
 if [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
  echo "${bold}$i${normal} will be installed"
  apt-get install $i
 elif [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 1 ]]; then
  echo "${bold}$i${normal} already installed installed"
 fi
done

echo
