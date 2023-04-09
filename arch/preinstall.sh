#!/bin/sh

echo $$ > preinstall.pid
dev=/dev/sda
efi=1
efi_size="+1G"
swap_size="+16G"

die ()
{
	echo "$@" 2>&1
}
#Executes fdisk commands from string
fdisker () {
	echo "$1" |
		tr ' ' '\n' |
		fdisk "$dev" > /dev/null 2>&1 ||
		die "failed."
}

die "syncing time"
timedatectl >/dev/null

die "unmounting partitions"
mount |
	grep "$dev" |
	tac |
	xargs umount 2>/dev/null
swapoff "${dev}1" 2> /dev/null
die "wiping drive"
wipefs -a "$dev" > /dev/null

die "creating swap partition"
fdisker "g n   $swap_size t  19 w"
mkswap "${dev}1" > /dev/null 2>&1
swapon "${dev}1"

if [ "$efi" -eq 0 ]
then
	root=2
else
	die "creating efi partition"
	fdisker "n   $efi_size t  1 w"
	root=3
fi

die "creating root partition"
fdisker "n    t  20 w"
mkfs.ext4 "${dev}$root" > /dev/null 2>&1
mount "${dev}$root" /mnt

# add efi
if [ "$efi" -eq 1 ]
then
	mkfs.fat -F 32 "${dev}2" > /dev/null 2>&1
	mount --mkdir "${dev}2" /mnt/boot
fi

die "done. :)"

die ""
die "--------------------------------------------------------"
lsblk -o name,type,fsused,size,fstype,mountpoint
die ""
fdisk -l "$dev" | tail -3
die "--------------------------------------------------------"
die ""

pacman -Sy --noconfirm archlinux-keyring > /dev/null 2>&1 || 
	exit 1
echo "install system?\n>"
read
pacstrap -K /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
rm preinstall.pid

die ""
die "copying installdrier over."
cd ..
mv arch /mnt/root/
die "done. :)"
