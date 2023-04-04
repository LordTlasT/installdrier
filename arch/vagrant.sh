#!/usr/bin/env sh
pacman --noconfirm -S \
	vagrant libvirt
vagrant plugin install vagrant-libvirt
vagrant plugin install vagrant-mutate
vagrant plugin install vagrant-rekey-ssh

