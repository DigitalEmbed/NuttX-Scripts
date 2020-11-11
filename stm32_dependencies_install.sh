#!/bin/bash
function title(){
	tput reset
	printf "[STM32 Dependencies Installer]\n"
}

function set_proxy(){
	while [ 1 ]; do
		printf "\n($counter) Do you want to, temporarily:\n"
		printf "[a] Set your pc's proxy?\n"
		printf "[b] Unset your proxy?\n"
		printf "[c] Do not change the proxy?\n"
		printf "[?] Option: "
		read proxy_answer
		case "$proxy_answer" in
		    a|A)
				printf "[-] Please enter the proxy IP: "
				read my_proxy_ip
				printf "[-] Please enter the proxy port: "
				read my_proxy_port
				http_proxy="http://${my_proxy_ip}:${my_proxy_port}/"
				https_proxy="https://${my_proxy_ip}:${my_proxy_port}/"
				ftp_proxy="ftp://${my_proxy_ip}:${my_proxy_port}/"
				printf "[-] http_proxy: ${http_proxy}"
				printf "\n[-] https_proxy: ${https_proxy}"
				printf "\n[-] ftp_proxy: ${ftp_proxy}\n"
				break		
		    ;;
		    b|B)
				unset http_proxy
				unset ftp_proxy
				unset https_proxy
				printf "[-] Proxy unseted!\n"
				break
		    ;;
		    c|C)
				break
		    ;;
		    *)
		        printf "[-] Invalid option!\n"
		    ;;
		esac
	done
	counter=$(($counter+1))
}

function apt_update(){
	printf "\n($counter) Updating APT...\n"
	sudo apt update
	counter=$(($counter+1))
}

function install_armgcc(){
	printf "\n($counter) Installing ARM-GCC...\n"
	sudo apt install -y gcc-arm-none-eabi
	counter=$(($counter+1))
}

function install_openocd(){
	printf "\n($counter) Installing OpenOCD...\n"
	sudo apt install -y openocd
	counter=$(($counter+1))
}

function finalize_installation(){
	printf "\n($counter) All dependencies have been installed!\n"
	read -n 1 -s -r -p "Press any key to continue..."
	printf "\n"
	counter=$(($counter+1))
}

function main(){
	counter=1

	title
	set_proxy
	apt_update
	install_armgcc
	install_openocd
	finalize_installation
}

main
