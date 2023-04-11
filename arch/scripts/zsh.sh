#!/bin/sh
pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions \
	2>&1 | grep "installing|Total"
chsh -s /bin/zsh $user 
chsh -s /bin/zsh
