pacman --noconfirm -S \
	neovim \ 
ln -sf /usr/bin/nvim /usr/bin/vim

# Dependencies
#packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
#lua lsp
pacman --noconfirm -S lua-language-server \
	npm \
	go \
	ripgrep
npm i -g live-server
#lsps
npm i -g unocss-language-server 
npm i -g typescript typescript-language-server
npm i -g emmet-ls
go install github.com/arduino/arduino-language-server@latest

#install plugins
nvim -c 'PackerSync'
dopac -S jedi-language-server
