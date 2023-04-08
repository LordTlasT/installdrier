# 1. Somstp 
# -- root passwd
# 2. pacinstaller
# -- aluc passwd
# -- aluc visudo
# 3. asaluc
dev="/dev/sda"
EFI=0
layout="us"
lang="en_US.UTF-8"
region="Europe/Brussels"
hostname="archidesktop"

# CHROOTED as root
#linking timezone
ln -sf /usr/share/zoneinfo/${region} /etc/localtime
#hardware clock
hwclock --systohc
#Locale
sed -i "s;#\(${lang}\);\1;g" /etc/locale.gen
locale-gen
#console keymap
echo "KEYMAP=${layout}" > /etc/vconsole.conf
#LANG
echo "LANG=${lang}" > /etc/locale.conf
#hostname
echo "${hostname}" > /etc/hostname
#Pacman conf
cat > /etc/hosts <<EOF
127.0.0.1           localost
::1                 localost
127.0.0.1           $hostname.localdomain $hostname
EOF

pacman --noconfirm -S grub
if [[ "$EFI" -eq 0 ]]
then
	grub-install --target=i386-pc $dev
else
	pacman --noconfirm -S efibootmgr
	grub-install --target=x86_64-efi --efi-directory=$dev --bootloader-id=GRUB
fi
	grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm -S dhcpcd
systemctl enable dhcpcd
