#!/bin/bash 

package=nexiste

sudo pacman -Syu $package >> package_install_results.log

if [[ $? -eq 0 ]]; then
	echo "The installation of $package was successful."
	echo "The new command is available here:"
	which $package
else 
	echo "The installation of $package failed." >> package_install_failure.log
fi

