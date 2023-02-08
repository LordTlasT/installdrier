#!/usr/bin/env bash

case ${BLOAT:-0} in
	0)
		pacman --noconfirm -S \
			alacritty \
			xmonad xmonad-contrib xmobar picom \
			dunst libnotify \
			numlockx redshift unclutter \
			maim
		;;
	1)
		pacman --noconfirm -S \
			kitty \
		;;
esac
