#!/bin/sh

usermod -aG wheel $user
pacman -S --noconfirm opendoas 2>&1 | grep "installing"
cat > /etc/doas.conf <<EOF
permit persist :wheel
permit nopass :wheel cmd reboot 
permit nopass :wheel cmd poweroff
EOF
chmod 0400 /etc/doas.conf
ln -sf /usr/local/bin/sudo /usr/bin/doas
