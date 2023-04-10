#!/bin/sh

# installing aur packages
export aurh=pikaur
./scripts/aur.sh
cat pkglists/aur1 | ${aurh} -S --noconfirm -

./scripts/createhome.sh

if ! doas doas -C /etc/doas.conf
then
	echo "Please install opendoas first."
	exit 1
fi
doas ./scripts/nvim.sh
