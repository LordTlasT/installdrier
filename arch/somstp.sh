#!/bin/sh

die ()
{
	echo "$1" >&2
}
pacs ()
{
	pacman -S --noconfirm $1 2>&1 | grep "installing"
}

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

die "installing grub"
pacman --noconfirm -S grub > /dev/null 2>&1
if [[ "$efi" -eq 0 ]]
then
	grub-install --target=i386-pc $dev
else
	pacs efibootmgr
	grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
fi
grub-mkconfig -o /boot/grub/grub.cfg

die "install networking packages"
pacs "dhcpcd iwd" 
systemctl enable dhcpcd
systemctl enable iwd
