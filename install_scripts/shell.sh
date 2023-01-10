#!/usr/bin/env bash

pacman --noconfirm -S \
  man-db man-pages bash-completion exa

pacman --noconfirm -S \
 zsh zsh-syntax-highlighting zsh-autosuggestions starship \
  || exit 1
chsh -s /bin/zsh ${user}
