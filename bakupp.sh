#!/bin/sh

bkpd="$(date +%y%m%d)_bakupp"

mkdir -p "${bkpd}"

# $1: root dir - $2: files
function cpfiles {
	mkdir -p "${bkpd}/${1:1}"
	for f in $2
	do
		cp -r "$1/${f}" "${bkpd}/${1:1}"
	done
}

cpfiles /etc "environment doas.conf hosts pacman.conf default/grub mkinitcpio.conf X11/xorg.conf security/faillock.conf pers.map.gz"
cpfiles ~ "docs music pictures movies zot"
cpfiles ~/.local/share/multimc "common"

tar czf "${bkpd}.tar.gz" "${bkpd}"
rm -rf "${bkpd}"
