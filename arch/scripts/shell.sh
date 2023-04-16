#!/bin/sh
pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions \
	dash \
	2>&1 | grep "installing|Total"
chsh -s /bin/zsh $user 
chsh -s /bin/zsh
ln -sf /usr/bin/dash /bin/sh
