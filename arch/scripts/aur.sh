#!/bin/sh

case "${aurh:-pikaur}" in
	"pikaur")
		git clone --depth 1 https://aur.archlinux.org/pikaur.git
		cd pikaur
		makepkg -fsri --noconfirm || exit 1
		cd ..
		rm -rf pikaur
		;;
	"paru")
		cd
		git clone --depth 1 https://aur.archlinux.org/paru.git
		cd paru
		makepkg -si --noconfirm || exit 1
		cd
		rm -rf paru
		;;
esac
