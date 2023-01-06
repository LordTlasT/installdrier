#!/bin/bash

export user="aluc"

usermod -aG wheel ${user}

pacman -Syu || exit 1

trap "Bye." EXIT

for script in install_scripts/*.sh
do
	./$script
done
