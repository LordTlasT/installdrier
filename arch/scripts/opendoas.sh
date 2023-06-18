#!/bin/sh

if [ -z "$user" ]
then
	die "E: variable 'user' not set."
	exit 1
fi

usermod -aG wheel $user
pacman -Sy --noconfirm opendoas
cat > /etc/doas.conf <<EOF
permit persist :wheel
permit nopass :wheel cmd reboot 
permit nopass :wheel cmd poweroff
EOF
chmod 0400 /etc/doas.conf
ln -sf /usr/bin/doas /usr/local/bin/sudo
