#!/bin/bash
function title(){
	tput reset
	printf "[NuttX Installer]\n"
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
	while [ 1 ]; do
	   	printf "\n($counter) Updating apt is highly recommended... Would you like to do that (Y/N)?"
		printf "\n[?] Option: "
		read update_answer
		case "$update_answer" in
		    y|Y)
				sudo apt update
				break
		    ;;
		    n|N)
				break
		    ;;
		    *)
		        printf "[-] Invalid option!"
		    ;;
		esac
	done
	counter=$(($counter+1))
}

function install_gcc(){
	printf "\n($counter) Installing GCC...\n"
	gcc_local=$(which gcc)
	if [[ -z "$gcc_local" ]]; then
		sudo apt install -y gcc
	else
		printf "[-] GCC is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_gpp(){
	printf "\n($counter) Installing G++...\n"
	gpp_local=$(which g++)
	if [[ -z "$gpp_local" ]]; then
		sudo apt install -y g++
	else
		printf "[-] G++ is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_gdb(){
	printf "\n($counter) Installing GDB...\n"
	gdb_local=$(which gdb)
	if [[ -z "$gdb_local" ]]; then
		sudo apt install -y gdb
	else
		printf "[-] GDB is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_make(){
	printf "\n($counter) Installing make...\n"
	make_local=$(which make)
	if [[ -z "$make_local" ]]; then
		sudo apt install -y make
	else
		printf "[-] Make is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_automake(){
	printf "\n($counter) Installing automake...\n"
	automake_local=$(which automake)
	if [[ -z "$automake_local" ]]; then
		sudo apt install -y automake
	else
		printf "[-] Automake is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_automake_115(){
	printf "\n($counter) Installing automake 1.15...\n"
	automake115_local=$(which automake-1.15)
	if [[ -z "$automake115_local" ]]; then
		sudo apt install -y automake-1.15
	else
		printf "[-] Automake 1.15 is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_autotools(){
	printf "\n($counter) Installing autotools...\n"
	autotools_local=$(which aclocal)
	if [[ -z "$autotools_local" ]]; then
		sudo apt install -y autotools-dev
	else
		printf "[-] Autotools is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_pkgconfig(){
	printf "\n($counter) Installing pkg-config...\n"
	pkgconfig_local=$(which pkg-config)
	if [[ -z "$pkgconfig_local" ]]; then
		sudo apt install -y pkg-config
	else
		printf "[-] Pkg-config is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_libncurses(){
	printf "\n($counter) Installing libncurses...\n"
	libncurses_test=$(dpkg -l libncurses*)
	if [[ ${#libncurses_test} -lt 100 ]]; then
		sudo apt install -y libncurses-dev
	else
		printf "[-] Libncurses is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_libgmp(){
	printf "\n($counter) Installing libgmp...\n"
	libgmp_test=$(dpkg -l libgmp*)
	if [[ ${#libgmp_test} -lt 100 ]]; then
		sudo apt install -y libgmp-dev
	else
		printf "[-] Libgmp is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_libgmp3(){
	printf "\n($counter) Installing libgmp3...\n"
	libgmp3_test=$(dpkg -l libgmp3*)
	if [[ ${#libgmp3_test} -lt 100 ]]; then
		sudo apt install -y libgmp3-dev
	else
		printf "[-] Libgmp3 is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_libmpfr(){
	printf "\n($counter) Installing libmpfr...\n"
	libmpfr_test=$(dpkg -l libmpfr*)
	if [[ ${#libmpfr_test} -lt 100 ]]; then
		sudo apt install -y libmpfr-dev
	else
		printf "[-] Libmpfr is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_libmpc(){
	printf "\n($counter) Installing libmpc...\n"
	libmpc_test=$(dpkg -l libmpc*)
	if [[ ${#libmpc_test} -lt 100 ]]; then
		sudo apt install -y libmpc-dev
	else
		printf "[-] Libmpc is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_flex(){
	printf "\n($counter) Installing flex...\n"
	flex_local=$(which flex)
	if [[ -z "$flex_local" ]]; then
		sudo apt install -y flex
	else
		printf "[-] Flex is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_bison(){
	printf "\n($counter) Installing bison...\n"
	bison_local=$(which bison)
	if [[ -z "$bison_local" ]]; then
		sudo apt install -y bison
	else
		printf "[-] Bison is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_byacc(){
	printf "\n($counter) Installing byacc...\n"
	byacc_local=$(which byacc)
	if [[ -z "$byacc_local" ]]; then
		sudo apt install -y byacc
	else
		printf "[-] Byacc is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_gperf(){
	printf "\n($counter) Installing gperf...\n"
	gperf_local=$(which gperf)
	if [[ -z "$gperf_local" ]]; then
		sudo apt install -y gperf
	else
		printf "[-] Gperf is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_openocd(){
	printf "\n($counter) Installing OpenOCD...\n"
	openocd_local=$(which openocd)
	if [[ -z "$openocd_local" ]]; then
		sudo apt install -y openocd
	else
		printf "[-] OpenOCD is already installed!\n"
	fi
	counter=$(($counter+1))
}

function install_nuttx(){
	printf "\n($counter) Installing NuttX...\n"
	git clone https://bitbucket.org/nuttx/nuttx
	git clone https://bitbucket.org/nuttx/apps
	git clone https://bitbucket.org/nuttx/tools
	cd tools/kconfig-frontends/
	./configure
	make
	sudo make install
	sudo ldconfig
	cd ../..
	cd nuttx/tools/
	./configure.sh stm32f103-minimum/nsh
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
	install_openocd
	install_nuttx
	finalize_installation
}

main
