#!/bin/bash

release_file=/etc/os-release

if grep -iq "Arch" $release_file; then
	# The host is based on Arch, run the pacman update command
	sudo pacman -Syu
fi

if grep -iq "Ubuntu" $release_file || grep -iq "Debian" $release_file; then
	# The host is based on Debian or Ubuntu, 
	# Run the apt version of the command
	sudo apt update
	sudo apt dist-upgrade
fi




