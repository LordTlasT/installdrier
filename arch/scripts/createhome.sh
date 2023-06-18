#!/bin/sh

die ()
{
	echo "$1" >&2
}

mkdir -p $HOME/src
git clone https://git.kallipso.be/dotfiles $HOME/src/dotfiles
cd $HOME/src/dotfiles
if [ "$setup" = "minimal" ]
then
	setup=s
else
	setup=d
fi
die "I: stowing for desktop setup"
./stowcmds.sh "$setup"
die "I: done."
