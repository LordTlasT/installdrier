#!/bin/sh

die ()
{
	echo "$@" >&2
}

die "I: testing internet connection"
if ! ping archlinux.org -W 4 -c 4 > /dev/null 2>&1
then
	die "E: connection was not succesful!"
	exit 1
fi

die "I: refreshing packages"
pacman -Sy --noconfirm archlinux-keyring >/dev/null 2>&1

# use lowercase to not interfere with env vars
export setup="${setup:-minimal}"
export dev="${dev:-/dev/sda}"
export efi=${efi:-0}
export layout="${layout:-us}"
export lang="${lang:-en_US.UTF-8}"
export region="${region:-Europe/Brussels}"
export hostname="${hostname:-archidesktop}"
export user="${user:-aluc}"
./somstp.sh

useradd -m -d /home/${user} ${user}

if [ "$setup" = "minimal" ]
then
	lists='
	cli
	shell'
else
	lists='
	cli
	audio
	DE
	gui
	hyprland
	misc
	shell
	theming'
fi

for list in $lists
do
	./pacin.sh $list
done

die "I: installing zsh"
./scripts/zsh.sh

die "I: installing opendoas"
./scripts/opendoas.sh
