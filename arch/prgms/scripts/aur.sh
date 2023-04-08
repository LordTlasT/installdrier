#!/bin/sh

case "${aurh:-pikaur}" in
	"pikaur")
		git clone https://aur.archlinux.org/pikaur.git
		cd pikaur
		makepkg -fsri
		cd ..
		rm -rf pikaur
		;;
	"paru")
		cd
		git clone https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si --noconfirm || exit
		cd
		rm -rf paru
		;;
esac
