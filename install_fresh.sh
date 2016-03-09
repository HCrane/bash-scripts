#!/bin/bash
################################################################################
# Custom standard install programm for freshly installed linux
# Written by Emanuel Moser
################################################################################



################################################################################
# Design
################################################################################
bold=$(tput bold)
normal=$(tput sgr0)
red=$(tput setaf 1)
green=$(tput setaf 2)
################################################################################



################################################################################
# Fetching new package list
# Declare if custom programs from the web will be downloaded
# 1 = true
# 0 = flase
################################################################################
apt-get update
CUSTOM_PROGRAMMS=1
################################################################################



################################################################################
declare -a INSTALL
################################################################################
# Declaration of the packages you want installed
# CUSTOM packages are used for special computers. e.g. not every pc of mine
# needs virtualbox. Can be commented out if not needed
################################################################################
CUSTOM1=virtualbox
CUSTOM2=chromium
CUSTOM3=kde-config-touchpad
INSTALL=( unrar unzip git htop curl firmware-iwlwifi $CUSTOM1 $CUSTOM2 $CUSTOM3 )

for i in "${INSTALL[@]}"
do
 if [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
  echo "[${red}NO${normal}]${bold}$i${normal} will be installed"
  apt-get install $i -y
 elif [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 1 ]]; then
  echo "${bold}$i${normal} already installed installed"
 fi
done
################################################################################



################################################################################
declare -a NAME
declare -a LINK
################################################################################
# Custom software that cannot be found in the package lists because of reasons
# !!!!!!!ATTENTION:The order is important how you add the names and links!!!!!!!
################################################################################
if [[ CUSTOM_PROGRAMMS -eq 1 ]]; then
  NAME=( atom gitkraken )
  LINK=( https://atom.io/download/deb https://release.gitkraken.com/linux/gitkraken-amd64.deb )
  x=0

  for i in "${NAME[@]}"
  do
   if [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 0 ]]; then
    echo "[${red}NO${normal}]${bold}$i${normal} will be installed"
    #creating -deb file with name of package
    filename="${NAME[$x]}.deb"
    wget -O $filename ${LINK[$x]}
    echo $filename
    dpkg -i $filename
    apt-get -f install -y
    rm -Rf $filename
    x=$((x+1))
   elif [[ $(dpkg-query -W -f='${Status}' $i 2>/dev/null | grep -c "ok installed") -eq 1 ]]; then
    echo "[${green}OK${normal}]${bold}$i${normal} already installed installed"
    x=$((x+1))
   fi
  done
fi
################################################################################
