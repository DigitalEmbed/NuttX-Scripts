#!/bin/bash
function title(){
	tput reset
	printf "[ESP32 Dependencies Installer]\n"
	printf "Thanks to: Sara Monteiro\n"
}

function create_new_project(){
	while [ 1 ]; do
		printf "\n($counter) Do you want create a new project (Y/N)?"
		printf "\n[?] Option: "
		read new_project_answer
		case "$new_project_answer" in
		    y|Y)
				make distclean
				./tools/configure.sh esp32-core/nsh
				break
		    ;;
		    n|N)
				break
		    ;;
		    *)
		        printf "[-] Invalid option!\n"
		    ;;
		esac
	done
	counter=$(($counter+1))
}

function show_menuconfig(){
	printf "\n($counter) Showing menuconfig...\n"
	make menuconfig
	counter=$(($counter+1))
}

function main(){
	counter=1
	title
	create_new_project
	show_menuconfig
}

main
