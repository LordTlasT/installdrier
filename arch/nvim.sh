pacman --noconfirm -S \
	neovim

#packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

#install plugins
nvim -c 'PackerSync'
