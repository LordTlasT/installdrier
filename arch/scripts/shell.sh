#!/bin/sh

if [ -z "$user" ]
then
	die "E: variable 'user' not set."
	exit 1
fi

pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions \
	dash
chsh -s /bin/zsh ${user:-aluc}
chsh -s /bin/zsh
ln -sf /usr/bin/dash /bin/sh
