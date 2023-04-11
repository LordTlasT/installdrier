#!/bin/sh

echo $$ > .preinstall.pid
dev=/dev/sda
efi=${1:-0}
efi_size="+1G"
swap_size="+16G"

die ()
{
	echo "$@" >&2
}
#Executes fdisk commands from string
fdisker () {
	echo "$1" |
		tr ' ' '\n' |
		fdisk -w always -W always "$dev" > /dev/null 2>&1 ||
		die "failed."
}

die "syncing time"
timedatectl >/dev/null

die "unmounting partitions"
mount |
	grep "$dev" |
	tac |
	xargs umount 2>/dev/null
swapoff "${dev}2" 2> /dev/null
die "wiping drive"
wipefs -af "$dev" > /dev/null

die "creating partition table"
fdisker "g w"

if [ "$efi" -eq 0 ]
then
	die "creating bios boot partition"
	fdisker "n   +1M t  4 w"
else
	die "creating efi partition"
	fdisker "n   $efi_size t  1 w"
fi
die "creating swap partition"
fdisker "n   $swap_size t  19 w"
die "creating root partition"
fdisker "n    t  20 w"

mkswap "${dev}2" > /dev/null 2>&1
swapon "${dev}2"

mkfs.ext4 "${dev}3" > /dev/null 2>&1
mount "${dev}3" /mnt

# add efi
if [ "$efi" -eq 1 ]
then
	mkfs.fat -F 32 "${dev}1" > /dev/null 2>&1
	mount --mkdir "${dev}1" /mnt/boot
fi

die "done. :)"

die ""
die "--------------------------------------------------------"
lsblk -o name,type,fsused,size,fstype,mountpoint
die ""
fdisk -l "$dev" | tail -3
die "--------------------------------------------------------"
die ""

if ! pacman -Sy --noconfirm archlinux-keyring 2>&1 | grep installing
then
	die "could not install keyring."
	exit 1
else
	die "installed keyring."
fi
echo "install system?\n>"
read
pacstrap -K /mnt base base-devel linux linux-firmware 2>&1 | grep "installing|Total"
genfstab -U /mnt >> /mnt/etc/fstab
rm .preinstall.pid

die ""
die "copying installdrier over."
cd ..
cp -r arch /mnt/root/
die "done. :)"