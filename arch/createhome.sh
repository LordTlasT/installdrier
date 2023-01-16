#!/bin/sh
u=/home/aluc

git clone git@craftmenners.men:dotfiles ${u}
git clone git@craftmenners.men:dotconfig ${u}/.config
git clone git@craftmenners.men:password-store ${u}/.password-store
git clone git@craftmenners.men:installdrier ${u}/installdrier
git clone git@craftmenners.men:dmenu ${u}/src/dmenu
git clone git@craftmenners.men:slock ${u}/src/slock
