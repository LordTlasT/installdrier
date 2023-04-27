# install latest stable release
wget --no-clobber --quiet --show-progress "https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb"
dpkg -i nvim-linux64.deb
apt install -f -y
rm nvim-linux64.deb

ln -sf /usr/bin/nvim /usr/local/bin/vim

# Dependencies
#packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
nvim "+PackerSync"
