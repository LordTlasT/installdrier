#!/usr/bin/env sh
pacman -S --noconfirm \
	tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
