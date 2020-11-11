#!/bin/bash
function title(){
	tput reset
	printf "[ESP32 Dependencies Installer]\n"
	printf "Thanks to: Sara Monteiro\n"
}

function select_port(){
	printf "\n($counter) Please select the output containing the ESP32 that will have its code uploaded.\n\n"
	for sysdevpath in $(find /sys/bus/usb/devices/usb*/ -name dev); do
	    (
	        syspath="${sysdevpath%/dev}"
	        devname="$(udevadm info -q name -p $syspath)"
	        [[ "$devname" == "bus/"* ]] && exit
	        eval "$(udevadm info -q property --export -p $syspath)"
	        [[ -z "$ID_SERIAL" ]] && exit
	        echo "/dev/$devname - $ID_SERIAL"
	    )
	done
	printf "\n[?] Option: /dev/tty"
	read esp32_port
	esp32_port="/dev/tty$esp32_port"
	counter=$(($counter+1))
}

function activate_virtual_environment(){
	printf "\n($counter) Activating virtual environment...\n"
	. $HOME/esp/esp-idf/export.sh
	counter=$(($counter+1))
}

function clear_old_binaries(){
	printf "\n($counter) Cleaning old binaries...\n"
	make clean
	counter=$(($counter+1))
}

function make_binary(){
	printf "\n($counter) Creating a new binary...\n"
	make
	counter=$(($counter+1))
}

function upload_binary(){
	printf "\n($counter) Uploading binary to ESP32...\n"
	esptool --chip esp32 elf2image --flash_mode dio --flash_size 4MB -o ./nuttx.bin nuttx
	esptool --chip esp32 --port $esp32_port --baud 921600 write_flash 0x1000 bootloader.bin 0x8000 partitions.bin 0x10000 nuttx.bin
	counter=$(($counter+1))
}

function finalize_upload(){
	printf "\n($counter) NuttX uploaded! "
	read -n 1 -s -r -p "Press any key to continue..."
	printf "\n"
	counter=$(($counter+1))
}

function main(){
	counter=1
	title
	select_port
	activate_virtual_environment
	clear_old_binaries
	make_binary
	upload_binary
	finalize_upload
}

main
