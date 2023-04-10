#!/bin/sh
pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions \
	2>&1 | grep "installing"
chsh -s /bin/zsh $user 
chsh -s /bin/zsh
