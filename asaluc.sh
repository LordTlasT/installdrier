#!/bin/bash

# Python packages
# pip install opencv-python
# pip install Pillow
# pip install virtualenv
# pip install mnamer

cd
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm || exit
cd
rm -rf paru

# paru --noconfirm -S \
#   aic94xx-firmware\
#   upd72020x-fw\
#   wd719x-firmware\
#   linux-firmware-qlogic\
#   || exit

systemctl --user enable pulseaudio.service
systemctl --user enable redshift
# vim
vim -c 'PlugInstall' -c 'quitall' \
    && ~/.vim/plugged/YouCompleteMe/install.py

# GPG IMPORT BOSS KEY

# DOES NOT WORK
# dmenu
cd $HOME/Builds/dmenu/dmenu-*
sudo make install || exit
cd

# Move Mononoki to TTF
echo "Copying fonts..."
sudo cp ~/ZoneOfTesting/repo/fonts/* /usr/share/fonts/TTF/
sudo fc-cache -v

# # Adjust PATH in /etc/ly/config.ini
# sudo systemctl enable ly.service
# echo "Adding ${HOME}/bin to PATH"
# sed -i \
#   "s;# *path = \(.*\)$;path = ${HOME}/bin:\1;g" \
#   /etc/ly/config.ini
