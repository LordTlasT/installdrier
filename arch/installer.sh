#!/bin/sh

die ()
{
	echo "$@" 2>&1
}

die "testing internet connection"
if ! ping archlinux.org -W 4 -c 4 > /dev/null 2>&1
then
	die "E: connection was not succesful!"
	exit 1
fi

die "refreshing packages"
pacman -Sy --noconfirm >/dev/null 2>&1

# use lowercase to not interfere with env vars
export dev="/dev/sda"
export efi=0
export layout="us"
export lang="en_US.UTF-8"
export region="Europe/Brussels"
export hostname="archidesktop"
export user="aluc"
./somstp.sh

for list in 'cli
audio
cli
DE
gui
hyprland
misc
shell
theming'
do
	die "installing $list"
	if pacman -S --noconfirm - 2> "/tmp/id-$list.txt" >/dev/null < pkglists/$list
	then
		die "succesful."
	else
		die "failed to install, log at /tmp/id-$list.txt"
	fi
done

die "installing zsh"
./scripts/zsh.sh

die "installing opendoas"
./scripts/opendoas.sh
