#!/bin/sh
pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions \
	>/dev/null 2>/dev/null
chsh -s /bin/zsh $user 
chsh -s /bin/zsh
