#!/usr/bin/env bash

case ${BLOAT:-0} in
	0)
		;;
	1)
		pacman --noconfirm -S nvidia nvidia-settings nvidia-utils
		# STEAM, careful install!!! libraries & shaders are gpu specific
		pacman --noconfirm -S wine wine-mono
		pacman --noconfirm -S steam lutris
		;;
esac
