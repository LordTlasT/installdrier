#!/bin/sh
pacman -S --noconfirm \
	zsh zsh-syntax-highlighting zsh-autosuggestions zsh-completions \
	dash
chsh -s /bin/zsh ${user:-aluc}
chsh -s /bin/zsh
ln -sf /usr/bin/dash /bin/sh
