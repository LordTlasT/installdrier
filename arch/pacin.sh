#!/bin/sh
die ()
{
	echo "$@" 2>&1
}

if [ "$#" -eq 0 ] 
then
	die "E: invalid usage."
	exit 1
elif [ ! -f "pkglists/$1" ]
then
	die "E: file not found."
	exit 1
elif [ "$(id -u)" -ne 0 ]
then
	die "E: please run as root"
	exit 1
fi
die "I: installing $1"

pacf="installing\|Total\|downloading"
if pacman -Sy --noconfirm - 2>&1 < pkglists/$1 | grep "$pacf"
then
	die "succesful."
else
	die "E: failed."
fi
