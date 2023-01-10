#!/usr/bin/env bash

pacman --noconfirm -S \
    virtualbox virtualbox-guest-iso
usermod -aG vboxusers "${user}"
modprobe vboxdrv vboxnetadp vboxnetflt

pacman --noconfirm -S \
virt-manager qemu-desktop libvirt edk2-ovmf dnsmasq iptables-nft
sudo usermod -aG libvirt "${user}"
echo "unix_sock_rw_perms = '0770'" | sudo tee -a /etc/libvirt/libvirtd.conf
echo "unix_sock_group = 'libvirt'" | sudo tee -a /etc/libvirt/libvirtd.conf
echo "user = ${user}"| sudo tee -a /etc/libvirt/qemu.conf
echo "group = ${user}" | sudo tee -a /etc/libvirt/qemu.conf
virsh pool-define-as VMs dir - - - - /home/aluc/Media/sdb/VMs
