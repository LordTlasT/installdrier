#!/bin/sh

pacf="installing\|Total\|downloading"
dev=/dev/sda
efi=0
efi_size="+1G"

die ()
{
	echo "$@" >&2
}
#Executes fdisk commands from string
fdisker () {
	echo "$1" |
		tr ' ' '\n' |
		fdisk -w always -W always "$dev" > /dev/null 2>&1 ||
		die "E: failed."
}

echo $$ > .preinstall.pid

die "I: Entered preinstall.sh"
die "variables:"
die "efi = $efi"
die "dev = $dev"
die "correct?"
echo -n ">" >&2
read

die "I: Syncing time"
timedatectl >/dev/null

die "I: Unmounting partitions"
mount |
	grep "$dev" |
	tac |
	xargs umount 2>/dev/null
die "I: Wiping drive"
wipefs -af "$dev" > /dev/null

die "I: Creating partition table"
fdisker "g w"

if [ "$efi" -eq 0 ]
then
	die "I: Creating bios boot partition"
	fdisker "n   +1M t  4 w"
else
	die "I: Creating efi partition"
	fdisker "n   $efi_size t  1 w"
fi
die "I: Creating root partition"
fdisker "n    t  20 w"

mkfs.ext4 "${dev}2" > /dev/null 2>&1
mount "${dev}2" /mnt

# add efi
if [ "$efi" -eq 1 ]
then
	mkfs.fat -F 32 "${dev}1" > /dev/null 2>&1
	mount --mkdir "${dev}1" /mnt/boot
fi

die "I: done. :)"

die ""
die "--------------------------------------------------------"
lsblk -o name,type,fsused,size,fstype,mountpoint
die ""
fdisk -l "$dev" | tail -3
die "--------------------------------------------------------"
die ""

die "I: installing keyring"
if ! pacman -Sy --noconfirm archlinux-keyring 2>&1 | grep "$pacf"
then
	die "E: could not install keyring."
	exit 1
else
	die "I: done."
fi
die "install system?"
echo -n ">" >&2
read
pacstrap -K /mnt base base-devel linux linux-firmware || exit 1
genfstab -U /mnt >> /mnt/etc/fstab
rm .preinstall.pid

die ""
die "I: Copying installdrier over."
cd ..
cp -r arch /mnt/root/
die "done. :)"
die ""

die "continue?"
echo -n ">" >&2
read
die "I: Installing from chroot."
arch-chroot /mnt sh <<EOF
cd /root/arch || exit 1
env dev=$dev efi=$efi ./installer.sh
EOF
