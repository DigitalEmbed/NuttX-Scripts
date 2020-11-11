#!/bin/bash
function title(){
	tput reset
	printf "[NuttX Full Installer]\n"
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
		printf "\n($counter) Enter the directory where you want to create and install NuttX. If you don't type, the files will be installed in the same location as this installer."
		printf "\n[?] Directory: "
		read directory_installation
		if [[ -d "$directory_installation" ]]; then
			printf "[-] $directory_installation exists on your filesystem... Please enter another directory.\n"
		elif [[ -z "$directory_installation" ]]; then
			printf "[-] Installing on $PWD/\n"
			break
		else
			printf "[-] Creating $directory_installation folder...\n"
			printf "[-] Installing on $PWD/$directory_installation/\n"
			mkdir -p "$directory_installation"
			chmod 755 "$directory_installation"
			chown $USER "$directory_installation"
			cd "$directory_installation"
			break
		fi
	done
	counter=$(($counter+1))
}

function apt_update(){
	printf "\n($counter) Updating APT...\n"
	sudo apt update
	counter=$(($counter+1))
}

function install_gcc(){
	printf "\n($counter) Installing GCC...\n"
	sudo apt install -y gcc
	counter=$(($counter+1))
}

function install_gpp(){
	printf "\n($counter) Installing G++...\n"
	sudo apt install -y g++
	counter=$(($counter+1))
}

function install_gdb(){
	printf "\n($counter) Installing GDB...\n"
	sudo apt install -y gdb
	counter=$(($counter+1))
}

function install_make(){
	printf "\n($counter) Installing make...\n"
	sudo apt install -y make
	counter=$(($counter+1))
}

function install_automake(){
	printf "\n($counter) Installing automake...\n"
	sudo apt install -y automake
	counter=$(($counter+1))
}

function install_automake_115(){
	printf "\n($counter) Installing automake 1.15...\n"
	sudo apt install -y automake-1.15
	counter=$(($counter+1))
}

function install_autotools(){
	printf "\n($counter) Installing autotools...\n"
	sudo apt install -y autotools-dev
	counter=$(($counter+1))
}

function install_pkgconfig(){
	printf "\n($counter) Installing pkg-config...\n"
	sudo apt install -y pkg-config
	counter=$(($counter+1))
}

function install_libncurses(){
	printf "\n($counter) Installing libncurses...\n"
	sudo apt install -y libncurses-dev
	counter=$(($counter+1))
}

function install_libgmp(){
	printf "\n($counter) Installing libgmp...\n"
	sudo apt install -y libgmp-dev
	counter=$(($counter+1))
}

function install_libgmp3(){
	printf "\n($counter) Installing libgmp3...\n"
	sudo apt install -y libgmp3-dev
	counter=$(($counter+1))
}

function install_libmpfr(){
	printf "\n($counter) Installing libmpfr...\n"
	sudo apt install -y libmpfr-dev
	counter=$(($counter+1))
}

function install_libmpc(){
	printf "\n($counter) Installing libmpc...\n"
	sudo apt install -y libmpc-dev
	counter=$(($counter+1))
}

function install_flex(){
	printf "\n($counter) Installing flex...\n"
	sudo apt install -y flex
	counter=$(($counter+1))
}

function install_bison(){
	printf "\n($counter) Installing bison...\n"
	sudo apt install -y bison
	counter=$(($counter+1))
}

function install_byacc(){
	printf "\n($counter) Installing byacc...\n"
	sudo apt install -y byacc
	counter=$(($counter+1))
}

function install_gperf(){
	printf "\n($counter) Installing gperf...\n"
	sudo apt install -y gperf
	counter=$(($counter+1))
}

function install_kconfig_frontends(){
	printf "\n($counter) Installing kconfing-frontends...\n"
	sudo apt-get install -y kconfig-frontends
	counter=$(($counter+1))
}

function install_nuttx(){
	printf "\n($counter) Installing NuttX...\n"
	git clone https://github.com/apache/incubator-nuttx.git nuttx
	git clone https://github.com/apache/incubator-nuttx-apps.git apps
	git clone https://bitbucket.org/nuttx/tools
	cd tools/kconfig-frontends/
	./configure
	make
	sudo make install
	sudo ldconfig
	cd ../..
	counter=$(($counter+1))
}

function finalize_installation(){
	printf "\n($counter) NuttX installed! "
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
	install_gcc
	install_gpp
	install_gdb
	install_make
	install_automake
	install_automake_115
	install_autotools
	install_pkgconfig
	install_libncurses
	install_libgmp
	install_libgmp3
	install_libmpfr
	install_libmpc
	install_flex
	install_bison
	install_byacc
	install_gperf
	install_kconfig_frontends
	install_nuttx
	finalize_installation
}

main
