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
log="/tmp/id-$1"
rm -f "$log"
if pacman -S --noconfirm - 2> "$log-error" > "$log-success" < pkglists/$1
then
	die "succesful."
else
	die "failed."
fi
die "log at $log"
