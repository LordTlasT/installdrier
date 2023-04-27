#!/bin/sh

die () {
	echo "$1" >&2
}

die "installing neovim"
doas pacman --noconfirm -S neovim > /dev/null 2>&1
die "symlinking vim"
doas ln -sf /usr/bin/nvim /usr/local/bin/vim

# Dependencies
#packer

die "installing packer"
git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 $HOME/.local/share/nvim/site/pack/packer/start/packer.nvim > /dev/null 2>&1

die "installing dependencies with pacman"
#lua lsp
doas pacman --noconfirm -S \
	lua-language-server \
	jedi-language-server \
	bash-language-server \
	npm \
	go \
	ripgrep 2>&1 | grep "installing|Total"

die "installing live server"
npm i -g live-server > /dev/null 2>&1
#lsps
die "unocss lsp"
npm i -g unocss-language-server  > /dev/null 2>&1
die "js lsp"
npm i -g typescript typescript-language-server > /dev/null 2>&1
die "emmet"
npm i -g emmet-ls > /dev/null 2>&1
die "arduino lsp"
go install github.com/arduino/arduino-language-server@latest > /dev/null 2>&1

#install plugins
nvim -c 'PackerSync'
