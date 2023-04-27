#!/usr/bin/env sh
pacs ()
{
	pacman -S --noconfirm $1
}

case ${1:-virtualbox} in
	"virtualbox")
		pacs "virtualbox virtualbox-guest-iso linux-headers" ||
			exit 1
		usermod -aG vboxusers "${user:=aluc}"
		modprobe vboxdrv vboxnetadp vboxnetflt
		;;
	"virtmanager")
		pacs "virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft"
		sudo usermod -aG libvirt "${user:=aluc}"
		echo "unix_sock_rw_perms = '0770'" | sudo tee -a /etc/libvirt/libvirtd.conf
		echo "unix_sock_group = 'libvirt'" | sudo tee -a /etc/libvirt/libvirtd.conf
		echo "user = ${user:=aluc}" | sudo tee -a /etc/libvirt/qemu.conf
		echo "group = ${user:=aluc}" | sudo tee -a /etc/libvirt/qemu.conf
		;;
esac
