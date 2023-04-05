#!/bin/sh

bkpd="$HOME/$(date +%y%m%d)_bakupp"

mkdir -p "${bkpd}"

# $1: root dir - $2: files
function cpfiles {
	mkdir -p "${bkpd}/${1:1}"
	for f in $2
	do
		echo "copying ${1/"$HOME"/\~}/${f} to ${bkpd}/${1:1}/${f}"
		cp -r "$1/${f}" "${bkpd}/${1:1}"
	done
}

cpfiles /etc "environment doas.conf hosts pacman.conf mkinitcpio.conf pers.map.gz"
cpfiles /etc/default "grub"
cpfiles /etc/X11 "xorg.conf"
cpfiles /etc/security/ "faillock.conf"

cpfiles ~ "dl docs music pics sync vids src"
cpfiles ~/.config/ "gnupg"
cpfiles ~/.local/share/multimc "common"
cpfiles ~/.local/share/ "appimages"

echo "compressing into archive"
tar cfz "${bkpd}.tar" "${bkpd}"
echo "removing non compressed"
rm -rf "${bkpd}"
