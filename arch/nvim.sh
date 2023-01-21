pacman --noconfirm -S \
	neovim \ 
	ripgrep

# Dependencies
#packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#lua lsp
pacman --noconfirm -S lua-language-server

#install plugins
nvim -c 'PackerSync'
