#!/bin/sh

die ()
{
	echo "$1" >&2
}

if [ -z "$user" ]
then
	die "E: variable 'user' not set."
	exit 1
fi
if ! doas doas -C /etc/doas.conf
then
	die "E: Please install opendoas first."
	exit 1
fi

die "I: Refreshing repositories"
doas pacman -Sy --noconfirm

export aurh=pikaur
die "I: Installing aur helper '$aur'"
./scripts/aur.sh
die "I: installing aur packages"
cat pkglists/aur1 | ${aurh} -S --noconfirm -

die "I: Creating home and config"
./scripts/createhome.sh
