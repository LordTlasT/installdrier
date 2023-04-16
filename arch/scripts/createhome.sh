#!/bin/sh

git clone https://git.kallipso.be/dotfiles $HOME/src/dotfiles
cd $HOME/src/dotfiles
./stowcmds.sh d 2>/dev/null > /dev/null
