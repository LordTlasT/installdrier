#!/usr/bin/env sh
git clone --depth 1 https://github.com/vim/vim
cd vim
pacman --noconfirm -S cmake
# Bug fix for YouCompleteMe plugin
export LDFLAGS="-rdynamic"
./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib/python3.10/config-3.10-x86_64-linux-gnu \
  --enable-gui=gtk2 \
  --enable-cscope \
  --prefix=/usr/local
make
make install || exit
cd
rm -rf vim
vim -c 'PlugInstall' -c 'quitall'
