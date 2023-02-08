#!/usr/bin/env bash

case ${BLOAT:-0} in
	0)
		pacman --noconfirm -S \
			dolphin \
			firefox passff-host \
			gimp \
			discord \
			signal-desktop
		;;
	1)
		pacman --noconfirm -S \
			evince \
			obs-studio kdenlive 
		;;
esac
