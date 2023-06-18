#!/bin/sh

die () {
	echo "$1" >&2
}

die "installing neovim"
pacman --noconfirm -Sy neovim
die "symlinking vim"
doas ln -sf /usr/bin/nvim /usr/local/bin/vi

# Dependencies
#packer

die "installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim

die "installing dependencies with pacman"
#lua lsp
doas pacman --noconfirm -S \
	lua-language-server \
	jedi-language-server \
	bash-language-server \
	npm \
	go \
	ripgrep

die "installing live server"
npm i -g live-server
#lsps
die "unocss lsp"
npm i -g unocss-language-server 
die "js lsp"
npm i -g typescript typescript-language-server
die "emmet"
npm i -g emmet-ls
die "arduino lsp"
go install github.com/arduino/arduino-language-server@latest
die "vscode-langservers-extracted"
npm i -g vscode-langservers-extracted
die "sql"
npm i -g sql-language-server
#install plugins
nvim -c 'PackerSync'
