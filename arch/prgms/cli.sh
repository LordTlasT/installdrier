#!/usr/bin/env sh
case ${BLOAT:-0} in
	0)
	pacman --noconfirm -S \
		nnn \
		htop \
		fzf \
		python3 python-pip \
		pacman-contrib pkgfile \
		zip unzip \
		wget yt-dlp \
		git openssh \
		mpv feh cmus \
		pass mutt \
		;;
	1)
	pacman --noconfirm -S \
		inetutils \
			pv
		;;
esac
