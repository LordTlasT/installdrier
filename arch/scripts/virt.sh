#!/usr/bin/env sh

case ${1:-virtualbox} in
	"virtualbox")
		pacman --noconfirm -S \
			virtualbox virtualbox-guest-iso \
			2>&1 | grep "installing\|Total"
		usermod -aG vboxusers "${user:=aluc}"
		modprobe vboxdrv vboxnetadp vboxnetflt
		;;
	"virtmanager")
		pacman --noconfirm -S \
			virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft \
			2>&1 | grep "installing|Total"
		sudo usermod -aG libvirt "${user:=aluc}"
		echo "unix_sock_rw_perms = '0770'" | sudo tee -a /etc/libvirt/libvirtd.conf
		echo "unix_sock_group = 'libvirt'" | sudo tee -a /etc/libvirt/libvirtd.conf
		echo "user = ${user:=aluc}" | sudo tee -a /etc/libvirt/qemu.conf
		echo "group = ${user:=aluc}" | sudo tee -a /etc/libvirt/qemu.conf
		;;
esac
