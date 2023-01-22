#!/bin/sh

bkpd="$(date +%y%m%d)_bakupp"

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

for directory in "." "installdrier" ".config" ".password-store"
do
	git clone --bare ~/"${directory}"/.git "${bkpd}/repos/${directory}.git"
done

cpfiles /etc "environment doas.conf hosts pacman.conf default/grub mkinitcpio.conf X11/xorg.conf security/faillock.conf pers.map.gz"
cpfiles ~ "docs music pictures movies zot"
cpfiles ~/.local/share/multimc "common"

echo "compressing"
tar czf "${bkpd}.tar.gz" "${bkpd}"
echo "removing non compressed"
rm -rf "${bkpd}"
