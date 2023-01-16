#!/bin/sh

bkpd="$(date +%y%m%d)_bakupp"

mkdir -p "${bkpd}"

# $1: root dir - $2: files
function cpdir {
	mkdir -p "${bkpd}/${1:1}"
	for f in $2
	do
		cp -r "$1/${f}" "${bkpd}/${1:1}"
	done
}

cpdir /etc "environment doas.conf hosts pacman.conf default/grub mkinitcpio.conf X11/xorg.conf security/faillock.conf pers.map.gz"
cpdir ~ "docs music pictures movies zot"
cpdir ~/.local/share/multimc/ "common"
