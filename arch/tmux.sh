#!/usr/bin/env sh
echo
echo "I: Starting tmux install script"
pacman -S --noconfirm \
	tmux

name="$(date +%H%M%S)-dummy"

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
echo "I: Creating dummy session"
tmux -d -s "$name"
echo "I: reloading config"
tmux source ~/.tmux.conf
echo "I: installing plugins"
~/.tmux/plugins/tpm/scripts/install_plugins.sh
echo "I: Killing dummy session"
tmux kill-session -t "$name"
echo "I: Done."
