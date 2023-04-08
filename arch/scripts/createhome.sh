#!/bin/sh

die ()
{
	echo "$@" 2>&1
}

mkdir -p $HOME/src
cd $HOME/src

for repo in dotfiles installdrier
do
	if git clone --depth 1 https://git.craftmenners.men/$repo 2>/dev/null
	then
		die "cloned $repo."
	else
		die "failed to clone $repo."
	fi
done

cd dotfiles
./stowcmds.sh d 2>/dev/null > /dev/null
