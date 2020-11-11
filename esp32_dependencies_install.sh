#!/bin/bash
function title(){
	tput reset
	printf "[ESP32 Dependencies Installer]\n"
	printf "Thanks to: Sara Monteiro\n"
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

function directory_installation(){
	while [ 1 ]; do
		printf "\n($counter) Enter your NuttX project directory."
		printf "\n[?] Directory: "
		read directory_installation
		if [[ -d "$directory_installation/nuttx" && -d "$directory_installation/tools" && -d "$directory_installation/apps" ]]; then
			directory_installation="$PWD/$directory_installation"
			printf "[-] Installing on $directory_installation/\n"
			break
		else
			printf "[-] $directory_installation is not a valid NuttX project... Please enter a valid NuttX directory.\n"
		fi
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

function install_wget(){
	printf "\n($counter) Installing Wget...\n"
	sudo apt install -y wget
	counter=$(($counter+1))
}

function install_flex(){
	printf "\n($counter) Installing Flex...\n"
	sudo apt install -y flex
	counter=$(($counter+1))
}

function install_bison(){
	printf "\n($counter) Installing Bison...\n"
	sudo apt install -y bison
	counter=$(($counter+1))
}

function install_gperf(){
	printf "\n($counter) Installing Gperf...\n"
	sudo apt install -y gperf
	counter=$(($counter+1))
}

function install_python3(){
	printf "\n($counter) Installing Python3...\n"
	sudo apt install -y python3
	counter=$(($counter+1))
}

function install_pip(){
	printf "\n($counter) Installing Pip...\n"
	sudo apt install -y python3-pip
	counter=$(($counter+1))
}

function install_python_setup_tools(){
	printf "\n($counter) Installing Python Setup Tools...\n"
	sudo apt install -y python-setuptools
	counter=$(($counter+1))
}

function install_cmake(){
	printf "\n($counter) Installing CMake...\n"
	sudo apt install -y cmake
	counter=$(($counter+1))
}

function install_ninja_build(){
	printf "\n($counter) Installing Ninja Build...\n"
	sudo apt install -y ninja-build
	counter=$(($counter+1))
}

function install_ccache(){
	printf "\n($counter) Installing Ccache...\n"
	sudo apt install -y ccache
	counter=$(($counter+1))
}

function install_libffi_dev(){
	printf "\n($counter) Installing Libffi-dev...\n"
	sudo apt install -y libffi-dev
	counter=$(($counter+1))
}

function install_libssl_dev(){
	printf "\n($counter) Installing Libssl-dev...\n"
	sudo apt install -y libssl-dev
	counter=$(($counter+1))
}

function install_dfu_util(){
	printf "\n($counter) Installing Dfu-util...\n"
	sudo apt install -y dfu-util
	counter=$(($counter+1))
}

function install_pyserial(){
	printf "\n($counter) Installing PySerial...\n"
	pip3 install -y pyserial
	counter=$(($counter+1))
}

function install_esptool(){
	printf "\n($counter) Installing ESPTool...\n"
	sudo apt install -y esptool
	counter=$(($counter+1))
}

function install_esp_idf(){
	printf "\n($counter) Installing ESP-IDF...\n"
	if [[ ! -d "${HOME}/esp" ]]; then
		mkdir -p ${HOME}/esp
	fi
	cd ${HOME}/esp
	git clone --recursive https://github.com/espressif/esp-idf.git
	cd "$directory_installation/nuttx"
	make -C tools/esp32/ ${HOME}/esp/esp-idf
	wget -O bootloader.bin https://github.com/saramonteiro/esp32_binaries_nuttx/blob/main/bootloader.bin?raw=true
	wget -O partitions.bin https://github.com/saramonteiro/esp32_binaries_nuttx/blob/main/partitions.bin?raw=true
	counter=$(($counter+1))
}

function configure_nuttx(){
	printf "\n($counter) Configuring NuttX for ESP32 board...\n"
	cd "$directory_installation/.."
	cp esp32_menuconfig.sh "$directory_installation/nuttx/esp32_menuconfig.sh"
	cp esp32_upload.sh "$directory_installation/nuttx/esp32_upload.sh"
	cd "$directory_installation/nuttx/tools"
	./configure.sh esp32-core/nsh
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
	directory_installation
	apt_update
	install_armgcc
	install_wget
	install_flex
	install_bison
	install_gperf
	install_python3
	install_pip
	install_python_setup_tools
	install_cmake
	install_ninja_build
	install_ccache
	install_libffi_dev
	install_libssl_dev
	install_dfu_util
	install_pyserial
	install_esptool
	install_esp_idf
	configure_nuttx
	finalize_installation
}

main
