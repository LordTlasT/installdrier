#!/bin/sh
die ()
{
	echo "$@" 2>&1
}

die "installing $1"

if [ "$#" -eq 0 ] 
then
	die "invalid usage."
	exit 1
elif [ ! -f "pkglists/$1" ]
then
	die "file not found."
	exit 1
fi

pacf="installing\|Total\|downloading"
if pacman -S --noconfirm - 2>&1 < pkglists/$1 | grep "$pacf"
then
	die "succesful."
else
	die "failed."
fi
