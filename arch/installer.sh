#!/bin/sh

die ()
{
	echo "$@" >&2
}

export setup="${setup:-minimal}"
export user="${user:-aluc}"

die "I: Testing internet connection"
if ! ping archlinux.org -W 4 -c k
then
	die "E: connection was not succesful!"
	exit 1
fi
die "I: Connection succesful."

die "I: Refreshing packages"
pacman -Sy --noconfirm archlinux-keyring

die "I: adding user '$user'"
useradd -m -d "/home/$user" "$user"

die "I: Installing for a $setup setup."
if [ "$setup" = "minimal" ]
then
	lists='
	cli
	shell'
else
	lists='
	cli
	audio
	DE
	gui
	hyprland
	misc
	shell
	theming'
fi
echo "lists: $lists"

for list in $lists
do
	./pacin.sh $list
done

die "I: Installing zsh and dash"
./scripts/shell.sh

die "I: Installing opendoas"
./scripts/opendoas.sh

if [ "$setup" != "minimal" ]
then
	die "I: Installing neovim"
	./scripts/nvim.sh
fi

die "W: Disabling passwords!"
die "Be sure to set a password for $user and root!!!"
passwd -d "$user"
passwd -d root
die "I: Installation done."
