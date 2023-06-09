#!/bin/sh

die () {
	echo "$1" >&2
}

if [ -z "$user" ]
then
	die "variable 'user' not set."
	exit 1
fi

if [ "$(id -u)" -ne 0 ]
then
	die "Please run this script as root."
	exit 1
fi

die "installing neovim"
pacman --noconfirm -Sy neovim
die "symlinking vim"
ln -sf /usr/bin/nvim /usr/local/bin/vi

# Dependencies
#packer

die "installing packer"
su $user -c "git clone --depth 1 https://github.com/wbthomason/packer.nvim \
 /home/$user/.local/share/nvim/site/pack/packer/start/packer.nvim"

die "installing dependencies with pacman"
#lua lsp
pacman --noconfirm -S \
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
