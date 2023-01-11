#!/usr/bin/env bash

cd
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm || exit
cd
rm -rf paru
