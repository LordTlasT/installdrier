#!/usr/bin/env bash
pacman --noconfirm  zsh 

# Dependencies
pacman --noconfirm -S \
  man-db man-pages bash-completion exa
# zsh
pacman --noconfirm -S \
 zsh-syntax-highlighting zsh-autosuggestions starship
curl -L git.io/antigen > ~/.zsh/antigen.zsh

  || exit 1
chsh -s /bin/zsh ${user}
