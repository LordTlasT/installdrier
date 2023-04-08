#!/bin/sh

ln -sf /usr/share/zoneinfo/${region} /etc/localtime
hwclock --systohc

sed -i "s;#\(${lang}\);\1;g" /etc/locale.gen
locale-gen

echo "KEYMAP=${layout}" > /etc/vconsole.conf
echo "LANG=${lang}" > /etc/locale.conf
echo "${hostname}" > /etc/hostname

cat > /etc/hosts <<EOF
127.0.0.1           localost
::1                 localost
127.0.0.1           $hostname.localdomain $hostname
EOF

pacman --noconfirm -S grub
if [[ "$efi" -eq 0 ]]
then
	grub-install --target=i386-pc $dev
else
	pacman --noconfirm -S efibootmgr
	grub-install --target=x86_64-efi --efi-directory=$dev --bootloader-id=GRUB
fi
	grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm -S dhcpcd
systemctl enable dhcpcd
