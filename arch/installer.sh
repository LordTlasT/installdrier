#!/bin/sh

die ()
{
	echo "$@" >&2
}

die "testing internet connection"
if ! ping archlinux.org -W 4 -c 4 > /dev/null 2>&1
then
	die "E: connection was not succesful!"
	exit 1
fi

die "refreshing packages"
pacman -Sy --noconfirm archlinux-keyring >/dev/null 2>&1

# use lowercase to not interfere with env vars
export dev="/dev/sda"
export efi=1
export layout="us"
export lang="en_US.UTF-8"
export region="Europe/Brussels"
export hostname="archidesktop"
export user="aluc"
./somstp.sh

useradd -m -d /home/${user} ${user}

lists='
cli
audio
cli
DE
gui
hyprland
misc
shell
theming'
for list in $lists
do
	./pacin.sh $list
done

die "installing zsh"
./scripts/zsh.sh

die "installing opendoas"
./scripts/opendoas.sh
