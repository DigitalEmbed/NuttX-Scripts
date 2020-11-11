#!/bin/bash
function title(){
	tput reset
	printf "[NuttX]\n"
	printf "\nNuttx is a real time embedded operating system (RTOS). Its goals are:"
	printf "\n - Standards compliance: POSIX and Linux;"
	printf "\n - Small footprint usable in deeply embedded, resource constrained environments;"
	printf "\n - Fully scalable from tiny (8-bit) to moderate (32-bit);"
	printf "\n - Standards compliance;"
	printf "\n - Real time;"
	printf "\n - Totally open.\n"
	printf "Think \"Tiny Linux\".\n"
	printf "\nScripts created by: Jorge Henrique Moreira Santana"
	printf "\nThanks to: Alan Carvalho de Assis\n"
	counter=$(($counter+1))
}

function nuttx_menu(){
	while [ 1 ]; do
		printf "\nPlease, select a option:\n"
		printf "[a] Establish Serial Connection\n"
		printf "[b] Full NuttX install\n"
		printf "[c] Fast NuttX install\n"
		printf "[d] STM32 dependencies install\n"
		printf "[e] ESP32 dependencies install\n"
		printf "[f] Exit\n"
		printf "[?] Option: "
		read nuttx_menu_answer
		case "$nuttx_menu_answer" in
		    a|A)
				bash ./establish_serial_connection.sh
		    ;;
		    b|B)
				bash ./full_install.sh
		    ;;
		    c|C)
				bash ./fast_install.sh
		    ;;
		    d|D)
				bash ./stm32_dependencies_install.sh
		    ;;
		    e|E)
				bash ./esp32_dependencies_install.sh
		    ;;
		    f|F)
				break
		    ;;
		    *)
		        printf "[-] Invalid option!\n"
		    ;;
		esac
		title
	done
}

function main(){
	boot
	title
	nuttx_menu
	tput reset
}

main