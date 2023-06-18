#!/bin/sh

pacf="installing\|Total\|downloading"
export setup="${setup:-minimal}"
export dev="${dev:-/dev/sda}"
export efi=${efi:-0}
export layout="${layout:-us}"
export lang="${lang:-en_US.UTF-8}"
export region="${region:-Europe/Brussels}"
export hostname="${hostname:-archidesktop}"
export user="${user:-aluc}"

die ()
{
	echo "$@" >&2
}

die "I: Entered installer.sh"
die "installing for:"
die "variables:"
die "setup: ${setup}"
die "dev: ${dev}"
die "efi: ${efi}"
die "layout: ${layout}"
die "lang: ${lang}"
die "region: ${region}"
die "hostname: ${hostname}"
die "user: ${user}"
die "Starting in 5s"
for n in 4 3 2 1
do
	die "$n"
	sleep 1s
done

die "I: Testing internet connection"
if ! ping archlinux.org -W 4 -c 4 > /dev/null 2>&1
then
	die "E: connection was not succesful!"
	exit 1
fi
die "I: Connection succesful."

die "I: Refreshing packages"
pacman -Sy --noconfirm archlinux-keyring 2>&1 | grep "$pacf"

# use lowercase to not interfere with env vars
./somstp.sh

useradd -m -d /home/${user} ${user}

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

die "W: Disabling passwords!"
die "Be sure to set a password for $user and root!!!"
passwd -d $user
passwd -d root
die "I: Installation done."
