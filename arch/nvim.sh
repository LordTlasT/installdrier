pacman --noconfirm -S \
	neovim \ 

# Dependencies
#packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#lua lsp
pacman --noconfirm -S lua-language-server \
	npm \
	ripgrep
npm i -g live-server
#lsps
npm i -g unocss-language-server 
npm i -g typescript typescript-language-server
npm i -g emmet-ls

#install plugins
nvim -c 'PackerSync'
dopac -S jedi-language-server
