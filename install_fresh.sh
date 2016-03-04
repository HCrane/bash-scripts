#!/bin/bash

#apt-get update
echo "Fetching new package lists"

declare -a INSTALL
INSTALL=( unrar unzip )

for i in "${INSTALL[@]}"
do
 if [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
  echo "$i not installes"
 elif [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 1 ]]; then
  echo "$i installed" 
 fi
done

echo
