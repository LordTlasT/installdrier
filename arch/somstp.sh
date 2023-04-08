# 1. Somstp 
# -- root passwd
# 2. pacinstaller
# -- aluc passwd
# -- aluc visudo
# 3. asaluc
dev="sda"
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
# sed -i 's;#\(ParallelDownloads\).*;\1 = 2;g' /etc/pacman.conf
echo "127.0.0.1           localost" \
  >> /etc/hosts
echo "::1                 localost" \
  >> /etc/hosts
echo "127.0.0.1           ${hostname}.localdomain ${hostname}" \
  >> /etc/hosts

pacman --noconfirm -S grub
grub-install --target=i386-pc /dev/${dev}
grub-mkconfig -o /boot/grub/grub.cfg

pacman --noconfirm -S dhcpcd
systemctl enable dhcpcd
