#!/bin/bash
function title(){
	tput reset
	printf "[Serial Connection Establisher]\n"
}

function establish_serial_connection(){
	printf "\n($counter) Establishing serial connection...\n"
	sudo usermod -a -G dialout $USER
	counter=$(($counter+1))
}

function finalize_installation(){
	printf "\n($counter) Serial connection established!\n"
	read -n 1 -s -r -p "Press any key to continue..."
	printf "\n"
	counter=$(($counter+1))
}

function main(){
	counter=1
	title
	establish_serial_connection
	finalize_installation
}

main
