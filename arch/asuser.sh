#!/bin/sh

# installing aur packages
env aur=pikaur ./scripts/aur.sh
cat pkglists/aur | 
	pikaur -S --noconfirm -

./scripts/createhome.sh

if ! doas -C /etc/doas.conf
then
	echo "Please install opendoas first."
	exit 1
fi
doas ./scripts/nvim.sh
