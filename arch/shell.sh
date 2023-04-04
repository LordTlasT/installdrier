#!/usr/bin/env bash

# Dependencies
pacman --noconfirm -S \
  man-db man-pages \
  bash-completion \
  exa \
  keychain
# zsh
pacman --noconfirm -S \
	zsh \
	zsh-syntax-highlighting \
	zsh-autosuggestions

  || exit 1
chsh -s /bin/zsh ${u:-aluc}

pacman --noconfirm -S \
	dash
ln -sf /usr/bin/dash /bin/sh
