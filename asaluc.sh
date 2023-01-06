#!/bin/bash

# Python packages
# pip install opencv-python
# pip install Pillow
# pip install virtualenv
# pip install mnamer

# paru --noconfirm -S \
#   aic94xx-firmware\
#   upd72020x-fw\
#   wd719x-firmware\
#   xf86-video-ast\
#   linux-firmware-qlogic\
#   || exit

systemctl --user enable pulseaudio.service
systemctl --user enable redshift
# vim
vim -c 'PlugInstall' -c 'quitall' \
    && ~/.vim/plugged/YouCompleteMe/install.py

# GPG IMPORT BOSS KEY

for dir in $(ls "$HOME/Builds")
do
    cd "$HOME/Builds/${dir}" || exit 1
    sudo make clean install || exit 1
done

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
